Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99742930D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhJKPXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 11:23:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231951AbhJKPXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:23:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BFBdkL024351;
        Mon, 11 Oct 2021 11:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8JdIijDsyFcyUndtQJTDx7Jep7qM7XiDzn473KgSPI8=;
 b=dQeuk1C9NhNv8wdNfiGSpOFgTfDHrohiXCDUCDP5IUolSe+r9oG4EBTCLrxBmE3g4ldl
 K0rRXAreO9pp5ZBO95ygRl8HGWa8QJ4jmfSGC1zr4usjASC9uUwZdIDGsOUt0SSUCPyL
 SLcYS3MmIP/MZCHyHUiir7prXeQocK77DS19YnvHDxN+x8st5D3ZD9ByDscPccaGzSVa
 PNFwZKc7t7oPxHueo6quzngZyne8lIxNR4sFD5c64oLoDIAe8aDyb7c1idDA2Y2VlXNu
 mdEuAkdA3MhFLyNDOL3zW2kidNmOVbd/ARK6guiuUrUU8D745sIAEEoqC0T6htGI4uoi tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmqpmg61b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 11:20:18 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19BFF3UR008574;
        Mon, 11 Oct 2021 11:20:17 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmqpmg602-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 11:20:16 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19BFDIbC014419;
        Mon, 11 Oct 2021 15:20:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q97292-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 15:20:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19BFKBKv19268016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 15:20:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9643DAE061;
        Mon, 11 Oct 2021 15:20:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FCBEAE057;
        Mon, 11 Oct 2021 15:20:03 +0000 (GMT)
Received: from sig-9-65-79-79.ibm.com (unknown [9.65.79.79])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Oct 2021 15:20:03 +0000 (GMT)
Message-ID: <539086ce33ed6417dd1ada1c8f593fc0edeb8f73.camel@linux.ibm.com>
Subject: Re: [PATCH v14 1/3] fs: Add trusted_for(2) syscall implementation
 and related sysctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Florian Weimer <fw@deneb.enyo.de>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?ISO-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Date:   Mon, 11 Oct 2021 11:20:02 -0400
In-Reply-To: <87tuhpynr4.fsf@mid.deneb.enyo.de>
References: <20211008104840.1733385-1-mic@digikod.net>
         <20211008104840.1733385-2-mic@digikod.net>
         <87tuhpynr4.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: izC9yhrEe1LpTrA6aSB26JuAwHzBGp1s
X-Proofpoint-ORIG-GUID: PawvuLLX4xcPVEed7b1tj13LIXgFSuK2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_05,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110088
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Florian,

On Sun, 2021-10-10 at 16:10 +0200, Florian Weimer wrote:
> * Mickaël Salaün:
> 
> > Being able to restrict execution also enables to protect the kernel by
> > restricting arbitrary syscalls that an attacker could perform with a
> > crafted binary or certain script languages.  It also improves multilevel
> > isolation by reducing the ability of an attacker to use side channels
> > with specific code.  These restrictions can natively be enforced for ELF
> > binaries (with the noexec mount option) but require this kernel
> > extension to properly handle scripts (e.g. Python, Perl).  To get a
> > consistent execution policy, additional memory restrictions should also
> > be enforced (e.g. thanks to SELinux).
> 
> One example I have come across recently is that code which can be
> safely loaded as a Perl module is definitely not a no-op as a shell
> script: it downloads code and executes it, apparently over an
> untrusted network connection and without signature checking.
> 
> Maybe in the IMA world, the expectation is that such ambiguous code
> would not be signed in the first place, but general-purpose
> distributions are heading in a different direction with
> across-the-board signing:

Automatically signing code is at least the first step in the right
direction of only executing code with known provenance.  Perhaps future
work would address the code signing granularity.

> 
>   Signed RPM Contents
>   <https://fedoraproject.org/wiki/Changes/Signed_RPM_Contents>
> 
> So I wonder if we need additional context information for a potential
> LSM to identify the intended use case.

My first thoughts were an enumeration UNSIGNED_DOWNLOADED_CODE or maybe
even UNTRUSTED_DOWNLOADED_CODE, but that doesn't seem very
helpful.  What type of context information were you thinking about?

Mimi

