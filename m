Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC647A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 08:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFQG47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 02:56:59 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33023 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfFQG46 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:56:58 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B16C3488195E49602C2C;
        Mon, 17 Jun 2019 07:56:56 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 17 Jun
 2019 07:56:49 +0100
Subject: Re: [PATCH v4 00/14] ima: introduce IMA Digest Lists extension
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20190614175513.27097-1-roberto.sassu@huawei.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <9029dd14-1077-ec89-ddc2-e677e16ad314@huawei.com>
Date:   Mon, 17 Jun 2019 08:56:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190614175513.27097-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/2019 7:54 PM, Roberto Sassu wrote:
> This patch set introduces a new IMA extension called IMA Digest Lists.
> 
> At early boot, the extension preloads in kernel memory reference digest
> values, that can be compared with actual file digests when files are
> accessed in the system.
> 
> The extension will open for new possibilities: PCR with predictable value,
> that can be used for sealing policies associated to data or TPM keys;
> appraisal based on reference digests already provided by Linux distribution
> vendors in the software packages.
> 
> The first objective can be achieved because the PCR values does not depend
> on which and when files are measured: the extension measures digest lists
> sequentially and files whose digest is not in the digest list.
> 
> The second objective can be reached because the extension is able to
> extract reference measurements from packages (with a user space tool) and
> use it as a source for appraisal verification as the reference came from
> the security.ima xattr. This approach will also reduce the overhead as only
> one signature is verified for many files (as opposed to one signature for
> each file with the current implementation).
> 
> This version of the patch set provides a clear separation between current
> and new functionality. First, the new functionality must be explicitly
> enabled from the kernel command line. Second, results of operations
> performed by the extension can be distinguished from those obtained from
> the existing code: measurement entries created by the extension have a
> different PCR; mutable files appraised with the extension have a different
> security.ima type.
> 
> The review of this patch set should start from patch 11 and 12, which
> modify the IMA-Measure and IMA-Appraise submodules to use digest lists.
> Patch 1 to 5 are prerequisites. Patch 6 to 10 adds support for digest
> lists. Finally, patch 13 introduces two new policies to measure/appraise
> rootfs and patch 14 adds the documentation (including a flow chart to
> show how IMA has been modified).
> 
> The user space tools to configure digest lists are available at:
> 
> https://github.com/euleros/digest-list-tools/releases/tag/v0.3
> 
> The patch set applies on top of linux-integrity/next-queued-testing
> (73589972b987).
> 
> It is necessary to apply also:
> https://patchwork.kernel.org/cover/10957495/

Another dependency is:

https://patchwork.kernel.org/cover/10979341/

Roberto


> To use appraisal, it is necessary to use a modified cpio and a modified
> dracut:
> 
> https://github.com/euleros/cpio/tree/xattr-v1
> https://github.com/euleros/dracut/tree/digest-lists
> 
> For now, please use it only in a testing environment.
> 
> 
> Changelog
> 
> v3:
> - move ima_lookup_loaded_digest() and ima_add_digest_data_entry() from
>    ima_queue.c to ima_digest_list.c
> - remove patch that introduces security.ima_algo
> - add version number and type modifiers to the compact list header
> - remove digest list metadata, all digest lists in the directory are
>    accessed
> - move loading of signing keys to user space
> - add violation for both PCRs if they are selected
> - introduce two new appraisal modes
> 
> v2:
> - add support for multiple hash algorithms
> - remove RPM parser from the kernel
> - add support for parsing digest lists in user space
> 
> v1:
> - add support for immutable/mutable files
> - add support for appraisal with digest lists
> 
> 
> Roberto Sassu (14):
>    ima: read hash algorithm from security.ima even if appraisal is not
>      enabled
>    ima: generalize ima_read_policy()
>    ima: generalize ima_write_policy() and raise uploaded data size limit
>    ima: generalize policy file operations
>    ima: use ima_show_htable_value to show violations and hash table data
>    ima: add parser of compact digest list
>    ima: restrict upload of converted digest lists
>    ima: prevent usage of digest lists that are not measured/appraised
>    ima: introduce new securityfs files
>    ima: load parser digests and execute the parser at boot time
>    ima: add support for measurement with digest lists
>    ima: add support for appraisal with digest lists
>    ima: introduce new policies initrd and appraise_initrd
>    ima: add Documentation/security/IMA-digest-lists.txt
> 
>   .../admin-guide/kernel-parameters.txt         |  16 +-
>   Documentation/security/IMA-digest-lists.txt   | 226 +++++++++++++
>   include/linux/evm.h                           |   6 +
>   include/linux/fs.h                            |   1 +
>   security/integrity/evm/evm_main.c             |   2 +-
>   security/integrity/iint.c                     |   1 +
>   security/integrity/ima/Kconfig                |  25 ++
>   security/integrity/ima/Makefile               |   1 +
>   security/integrity/ima/ima.h                  |  32 +-
>   security/integrity/ima/ima_api.c              |  43 ++-
>   security/integrity/ima/ima_appraise.c         |  92 +++---
>   security/integrity/ima/ima_digest_list.c      | 309 ++++++++++++++++++
>   security/integrity/ima/ima_digest_list.h      |  69 ++++
>   security/integrity/ima/ima_fs.c               | 224 ++++++++-----
>   security/integrity/ima/ima_init.c             |   2 +-
>   security/integrity/ima/ima_main.c             |  81 ++++-
>   security/integrity/ima/ima_policy.c           |  29 +-
>   security/integrity/integrity.h                |  22 ++
>   18 files changed, 1018 insertions(+), 163 deletions(-)
>   create mode 100644 Documentation/security/IMA-digest-lists.txt
>   create mode 100644 security/integrity/ima/ima_digest_list.c
>   create mode 100644 security/integrity/ima/ima_digest_list.h
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
