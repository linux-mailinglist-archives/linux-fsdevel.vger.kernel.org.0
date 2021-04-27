Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBA36C8BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhD0Pft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 11:35:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229571AbhD0Pfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:35:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RFXC14030239;
        Tue, 27 Apr 2021 11:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=w8APLkGIxh0rs/Wpr76LrK507rVPF46QHjwU3RO8BVY=;
 b=f/98XhTnaN92HmAR3tl1kdnCSg61Jr7DwWt9/0YvQMOwvlfvOZ6rrrfOYySQaNaWPCG8
 ob7o+NevAU2gVmDOyRLfJ83MkcHmordYU7TPf6L9ZNvaFkcu4SbTt2H/SnKfwvXRyjrB
 Dv06/6HxWAVSPjXlYIrTjMzgBqaHaWdthay4PO3G41ypdo7ZXRcwPfY34TTz4yMaRKYo
 NjpSQ8wVAPG7zQbCuvAl9WHkCSG8GZ1o4douKQMMAWab1/x44M9dwNP1GdtTRma9AWMU
 J61CtiGICHmfzesvPVdIumfINkMOcBUrzJOm3eV2ieOf2AbYeIcNFRt73sTcTZP3slYQ Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386hjch0mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 11:35:01 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RFYSIh039261;
        Tue, 27 Apr 2021 11:35:00 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386hjch0ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 11:35:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RFHh1I016742;
        Tue, 27 Apr 2021 15:34:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 384akh9e3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:34:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RFYUHM27591096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 15:34:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 428EBA4054;
        Tue, 27 Apr 2021 15:34:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58E91A405C;
        Tue, 27 Apr 2021 15:34:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.36.231])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 15:34:52 +0000 (GMT)
Message-ID: <d047d1347e7104162e0e36eb57ade6bba914ea2d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Apr 2021 11:34:51 -0400
In-Reply-To: <7a39600c24a740838dca24c20af92c1a@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
         <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
         <7a39600c24a740838dca24c20af92c1a@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r6y4VwTF8AaFgQ4HP7af5phuJF68seLq
X-Proofpoint-GUID: DF7zkX2QQSjHy6QaOf_0ObKIUqKv21Xb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_08:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=898 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270108
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-27 at 09:25 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, April 26, 2021 9:49 PM
> > On Fri, 2021-03-05 at 09:30 -0800, Casey Schaufler wrote:

> > > However ...
> > >
> > > The special casing of IMA and EVM in security.c is getting out of
> > > hand, and appears to be unnecessary. By my count there are 9 IMA
> > > hooks and 5 EVM hooks that have been hard coded. Adding this IMA
> > > hook makes 10. It would be really easy to register IMA and EVM as
> > > security modules. That would remove the dependency they currently
> > > have on security sub-system approval for changes like this one.
> > > I know there has been resistance to "IMA as an LSM" in the past,
> > > but it's pretty hard to see how it wouldn't be a win.

It sholdn't be one way.  Are you willing to also make the existing
IMA/EVM hooks that are not currently security hooks, security hooks
too?   And accept any new IMA/EVM hooks would result in new security
hooks?  Are you also willing to add dependency tracking between LSMs?

> > 
> > Somehow I missed the new "lsm=" boot command line option, which
> > dynamically allows enabling/disabling LSMs, being upstreamed.  This
> > would be one of the reasons for not making IMA/EVM full LSMs.
> 
> Hi Mimi
> 
> one could argue why IMA/EVM should receive a special
> treatment. I understand that this was a necessity without
> LSM stacking. Now that LSM stacking is available, I don't
> see any valid reason why IMA/EVM should not be managed
> by the LSM infrastructure.
> 
> > Both IMA and EVM file data/metadata is persistent across boots.  If
> > either one or the other is not enabled the file data hash or file
> > metadata HMAC will not properly be updated, potentially preventing the
> > system from booting when re-enabled.  Re-enabling IMA and EVM would
> > require "fixing" the mutable file data hash and HMAC, without any
> > knowledge of what the "fixed" values should be.  Dave Safford referred
> > to this as "blessing" the newly calculated values.
> 
> IMA/EVM can be easily disabled in other ways, for example
> by moving the IMA policy or the EVM keys elsewhere.

Dynamically disabling IMA/EVM is very different than removing keys and
preventing the system from booting.  Restoring the keys should result
in being able to re-boot the system.  Re-enabling IMA/EVM, requires re-
labeling the filesystem in "fix" mode, which "blesses" any changes made
when IMA/EVM were not enabled.

> Also other LSMs rely on a dynamic and persistent state
> (for example for file transitions in SELinux), which cannot be
> trusted anymore if LSMs are even temporarily disabled.

Your argument is because this is a problem for SELinux, make it also a
problem for IMA/EVM too?!   ("Two wrongs make a right")

> If IMA/EVM have to be enabled to prevent misconfiguration,
> I think the same can be achieved if they are full LSMs, for
> example by preventing that the list of enabled LSMs changes
> at run-time.

That ship sailed when "security=" was deprecated in favor of "lsm="
support, which dynamically enables/disables LSMs at runtime.

Mimi

