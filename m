Return-Path: <linux-fsdevel+bounces-16664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040CF8A1278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 13:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B314628301F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBD01474C3;
	Thu, 11 Apr 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="E+av8V1v";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="PQuAJ0qb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1E1474BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833437; cv=none; b=ddnF9TAN703/MZ1BHWr49Xz/qhrtNcGX2q40ThMpkuRLPYEKIpsB4rCOhlAU0yW0cVBVT1HuKI/ujw4Q+aAT0k9NOBeizZfg5+Ynd9ROwzO9kI5kUzSTmTQSYDfObxwm45kap+sD+ufekg7/C1CFnhXET21JkkK0LrLo2sYrnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833437; c=relaxed/simple;
	bh=MSFm1EBGmR2LLH6gGZRgCleHJVzYSGXKoQaTGT2aZn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BZYgGnUlZn2SKkHQSgPDMqO1szpfqp+bt0sw1Xtp4K0q+Lac53+gNQchEXCQtqeq6zezQEYOYCsdm1uaF5Ml03JUCHZJoTsQZx5+rHaLm9kZhKMYSfTNF5OzCVJoW899xQQWAt85mFAmVGzybuNH/7edXZZDb/GCzPnl1fhRK7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=E+av8V1v; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=PQuAJ0qb; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7673F21C9;
	Thu, 11 Apr 2024 10:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1712832987;
	bh=SwPj2AqRGe9EKGQD5/g1nxPhpUMvHtRCkQf9C+uu+cE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E+av8V1vKLYJqxE7KjFej4qFk6fsvOTM3Fz39RvH1jAkaKvbkswHzV4nLp2MRc4Gy
	 ql3LHp0J5j0PU7FMULek2PQ1FiCGZV5VdeoNAT5T8oX9/l9J9nPhvLSp95Ec0mpoq/
	 FmqViTZmmwV5QUeH/GJJp6Z/y03YmL07J3p5/TT0=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 690381D3B;
	Thu, 11 Apr 2024 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1712833433;
	bh=SwPj2AqRGe9EKGQD5/g1nxPhpUMvHtRCkQf9C+uu+cE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PQuAJ0qbHs67I+20oz0pVuV7L2TyeUN0W4GNYGky+eSlnK/Y6y5cD3DQ0vxXiMSlJ
	 cOfU02eJPgyd7O40MJRSkOXZZC90EblgFrEsL8gUUPMN/j0UJFBWPJy0YU+OJqlkuK
	 uP+tzVVsCnmCiv9+VTlwdE5cXxlMZ/m8akEb3Ay8=
Received: from [192.168.211.72] (192.168.211.72) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Apr 2024 14:03:52 +0300
Message-ID: <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
Date: Thu, 11 Apr 2024 14:03:52 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ntfs3: remove warning
To: Linux regressions mailing list <regressions@lists.linux.dev>, Christian
 Brauner <brauner@kernel.org>, Johan Hovold <johan@kernel.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Anton Altaparmakov
	<anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>,
	<ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-ntfs-dev@lists.sourceforge.net>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 04.04.2024 11:06, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 25.03.24 13:05, Christian Brauner wrote:
>> On Mon, Mar 25, 2024 at 11:12:00AM +0100, Johan Hovold wrote:
>>> On Mon, Mar 25, 2024 at 09:34:38AM +0100, Christian Brauner wrote:
>>>> This causes visible changes for users that rely on ntfs3 to serve as an
>>>> alternative for the legacy ntfs driver. Print statements such as this
>>>> should probably be made conditional on a debug config option or similar.
>>>>
>>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>>> Cc: Johan Hovold <johan@kernel.org>
>>>> Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>>>
>>> I also see a
>>>
>>> 	ntfs3: Max link count 4000
>>>
>>> message on mount which wasn't there with NTFS legacy. Is that benign
>>> and should be suppressed too perhaps?
>> We need a reply from the ntfs3 maintainers here.
> Those are known for taken their time to respond -- like we see here, as
> nothing happened for 10 days now. Which makes we wonder: should we at
> least bring the first patch from this series onto the track towards
> mainline?
>
> FWIW, quick side note: just noticed there was another report about the
> "Correct links count -> 1." messages:
> https://lore.kernel.org/all/6215a88a-7d78-4abb-911f-8a3e7033da3e@gmx.com/
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot duplicate:
> https://lore.kernel.org/all/6215a88a-7d78-4abb-911f-8a3e7033da3e@gmx.com/
> #regzbot poke
>
Hello Christian, Johan, all,

There is no problem in suppressing the output of any messages during 
mounting, like:

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cef5467fd928..4643b06b1550 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1804,8 +1804,6 @@ static int __init init_ntfs_fs(void)
{
         int err;
-       pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
-
         if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
                 pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
         if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))

Messages like this:

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index eb7a8c9fba01..8cc94a6a97ed 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -424,7 +424,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
     if (names != le16_to_cpu(rec->hard_links)) {
         /* Correct minor error on the fly. Do not mark inode as dirty. */
-        ntfs_inode_warn(inode, "Correct links count -> %u.", names);
         rec->hard_links = cpu_to_le16(names);
         ni->mi.dirty = true;
     }

can also be suppressed for the sake of seamless transition from a remote 
NTFS driver.
However, I believe that file system corrections should be reported to 
the user.



