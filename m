Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530BC450197
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 10:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhKOJpI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 04:45:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4094 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKOJpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:45:07 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ht43K5DVKz67lMW;
        Mon, 15 Nov 2021 17:42:05 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 10:42:09 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.020;
 Mon, 15 Nov 2021 10:42:09 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>, "corbet@lwn.net" <corbet@lwn.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "deven.desai@linux.microsoft.com" <deven.desai@linux.microsoft.com>,
        "wufan@linux.microsoft.com" <wufan@linux.microsoft.com>
Subject: RE: [RFC][PATCH 2/5] fsverity: Revalidate built-in signatures at file
 open
Thread-Topic: [RFC][PATCH 2/5] fsverity: Revalidate built-in signatures at
 file open
Thread-Index: AQHX18MQyymJ+lWsYUGROsvm6WBSwawAMuSAgAQZWoA=
Date:   Mon, 15 Nov 2021 09:42:09 +0000
Message-ID: <ae418bcd4d074500b417b74af5db11b2@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-3-roberto.sassu@huawei.com>
 <YY69NaucW+0t474Q@gmail.com>
In-Reply-To: <YY69NaucW+0t474Q@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Eric Biggers [mailto:ebiggers@kernel.org]
> Sent: Friday, November 12, 2021 8:15 PM
> On Fri, Nov 12, 2021 at 01:44:08PM +0100, Roberto Sassu wrote:
> > Fsverity signatures are validated only upon request by the user by setting
> > the requirement through procfs or sysctl.
> >
> > However, signatures are validated only when the fsverity-related
> > initialization is performed on the file. If the initialization happened
> > while the signature requirement was disabled, the signature is not
> > validated again.
> 
> I'm not sure this really matters.  If someone has started using a verity file
> before the require_signatures sysctl was set, then there is already a race
> condition; this patch doesn't fix that.  Don't you need to set the
> require_signatures sysctl early enough anyway?

Yes, access to already opened files is not revoked. It will work
for a new open. Actually, the main reason for this patch was that
one of the tests in xfstests-dev fails (generic/577).

While persistent filesystems are unmounted and mounted before
the test, which causes the fsverity_info structure to be removed
from the inode, requiring a new verification, tmpfs is just remounted.
During remount, the fsverity_info structure of already instantiated
inodes is kept.

Since fsverity_verify_signature() is called only when the
fsverity_info structure is created, all files with that structure are
considered valid, even if signature verification was temporarily
disabled at the time the structure was created.

Requiring signature verification early could be a solution, but
it is still at discretion of root. Maybe it would be a good idea to
disable the interface with a kernel option, so that signatures
can be enforced in a mandatory way.

This patch probably helps more LSMs, by exposing the information
of whether the signature was validated, to make their decision
depending on their policy.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua
