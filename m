Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B434736C909
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhD0QFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:05:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233501AbhD0QFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:05:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RG4CQq175561;
        Tue, 27 Apr 2021 12:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=t8cu/X/KuqBNRzGyfh9KZctMfN6zLY5UWrMch/NUD84=;
 b=bSbtLy+wWDtEzM2chjsg2FXTbh28p9b4BQJBZvEm6IsnzMdslgJLXim48PJzjZCRYEjE
 5fvjSO1d+Pwc4M46zDNdaJmXhsTkFQLC7R2Hyu3+Ot2rLTzxTC4/q2cGOjZS6rzn+AcU
 GXKN03LOyC4+GxH0+ChzDR8iboEcfMCTdpd783zMemWY85xzTpl8/8aWdf1IC7MeAPmE
 kZVEPmN54wOZEgUaekT0GyIzMB547ZwfFNECfwGaXEvE4As5PXW+1h0XYy5xMVtsALse
 ivW2bXkrtTFfUWU8bLYc8Aj3/X/y5hVYikGF58NOTqtS6FALJterraZ1HV6ZXQozfwLQ /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386nqxg5tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 12:04:24 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RG4EQJ175939;
        Tue, 27 Apr 2021 12:04:24 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386nqxg5sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 12:04:23 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RG0iZb016038;
        Tue, 27 Apr 2021 16:04:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 384ay80tab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 16:04:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RG3s4122610304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 16:03:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2FF52059;
        Tue, 27 Apr 2021 16:04:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.36.231])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 58EF05204E;
        Tue, 27 Apr 2021 16:04:16 +0000 (GMT)
Message-ID: <821796ff548c58138be547e0e5f4d7ba432356a7.camel@linux.ibm.com>
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
Date:   Tue, 27 Apr 2021 12:03:58 -0400
In-Reply-To: <d783e2703248463f9af68e155ee65c38@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
         <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
         <7a39600c24a740838dca24c20af92c1a@huawei.com>
         <d047d1347e7104162e0e36eb57ade6bba914ea2d.camel@linux.ibm.com>
         <d783e2703248463f9af68e155ee65c38@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q2A686-wULx0MY3SMC_bBSa1UowCxs90
X-Proofpoint-GUID: 4pXHFRmb25tcfpBkd3m_6AB-cPVgXi-5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_08:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=982 suspectscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270111
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-27 at 15:57 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Tuesday, April 27, 2021 5:35 PM
> > On Tue, 2021-04-27 at 09:25 +0000, Roberto Sassu wrote:
> > > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > > Sent: Monday, April 26, 2021 9:49 PM
> > > > On Fri, 2021-03-05 at 09:30 -0800, Casey Schaufler wrote:
> > 
> > > > > However ...
> > > > >
> > > > > The special casing of IMA and EVM in security.c is getting out of
> > > > > hand, and appears to be unnecessary. By my count there are 9 IMA
> > > > > hooks and 5 EVM hooks that have been hard coded. Adding this IMA
> > > > > hook makes 10. It would be really easy to register IMA and EVM as
> > > > > security modules. That would remove the dependency they currently
> > > > > have on security sub-system approval for changes like this one.
> > > > > I know there has been resistance to "IMA as an LSM" in the past,
> > > > > but it's pretty hard to see how it wouldn't be a win.
> > 
> > It sholdn't be one way.  Are you willing to also make the existing
> > IMA/EVM hooks that are not currently security hooks, security hooks
> > too?   And accept any new IMA/EVM hooks would result in new security
> > hooks?  Are you also willing to add dependency tracking between LSMs?
> 
> I already have a preliminary branch where IMA/EVM are full LSMs.
> 
> Indeed, the biggest problem would be to have the new hooks
> accepted. I can send the patch set for evaluation to see what
> people think.

Defining new security hooks is pretty straight forward.   Perhaps at
least wait until Casey responds before posting the patches.

> 
> > > > Somehow I missed the new "lsm=" boot command line option, which
> > > > dynamically allows enabling/disabling LSMs, being upstreamed.  This
> > > > would be one of the reasons for not making IMA/EVM full LSMs.
> > >
> > > Hi Mimi
> > >
> > > one could argue why IMA/EVM should receive a special
> > > treatment. I understand that this was a necessity without
> > > LSM stacking. Now that LSM stacking is available, I don't
> > > see any valid reason why IMA/EVM should not be managed
> > > by the LSM infrastructure.
> > >
> > > > Both IMA and EVM file data/metadata is persistent across boots.  If
> > > > either one or the other is not enabled the file data hash or file
> > > > metadata HMAC will not properly be updated, potentially preventing the
> > > > system from booting when re-enabled.  Re-enabling IMA and EVM would
> > > > require "fixing" the mutable file data hash and HMAC, without any
> > > > knowledge of what the "fixed" values should be.  Dave Safford referred
> > > > to this as "blessing" the newly calculated values.
> > >
> > > IMA/EVM can be easily disabled in other ways, for example
> > > by moving the IMA policy or the EVM keys elsewhere.
> > 
> > Dynamically disabling IMA/EVM is very different than removing keys and
> > preventing the system from booting.  Restoring the keys should result
> > in being able to re-boot the system.  Re-enabling IMA/EVM, requires re-
> > labeling the filesystem in "fix" mode, which "blesses" any changes made
> > when IMA/EVM were not enabled.
> 
> Uhm, I thought that if you move the HMAC key for example
> and you boot the system, you invalidate all files that change,
> because the HMAC is not updated.

More likely you wouldn't be able to boot the system without the HMAC
key.

Mimi

> 
> > > Also other LSMs rely on a dynamic and persistent state
> > > (for example for file transitions in SELinux), which cannot be
> > > trusted anymore if LSMs are even temporarily disabled.
> > 
> > Your argument is because this is a problem for SELinux, make it also a
> > problem for IMA/EVM too?!   ("Two wrongs make a right")
> 
> To me it seems reasonable to give the ability to people to
> disable the LSMs if they want to do so, and at the same time
> to try to prevent accidental disable when the LSMs should be
> enabled.
> 
> > > If IMA/EVM have to be enabled to prevent misconfiguration,
> > > I think the same can be achieved if they are full LSMs, for
> > > example by preventing that the list of enabled LSMs changes
> > > at run-time.
> > 
> > That ship sailed when "security=" was deprecated in favor of "lsm="
> > support, which dynamically enables/disables LSMs at runtime.
> 
> Maybe this possibility can be disabled with a new kernel option.
> I will think a more concrete solution.
> 
> Roberto
> 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli


