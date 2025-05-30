Return-Path: <linux-fsdevel+bounces-50232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1EAC9338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26281C06705
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBD2356A9;
	Fri, 30 May 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbV80vqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C8235345;
	Fri, 30 May 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621702; cv=none; b=ucZoS4kAF7RPVJ7rGs1OWK/wblOEIDBWvA2cysnQCzp+SK0EIetx2SzrYWsGVaUPjovRmjFXNZCAkDLtBwhcF6lMJ9zQ+2npiZg31GlYoX3zwoXpiDAxCP1RDjIt2mL0Ld1oo7sD8wvr2g1n+sgy22oGowPBFR66vVp93874bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621702; c=relaxed/simple;
	bh=3ZvnrvTmAK5qowvGTfd5VbRglX0pdlRCpg3q/YgkHvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSdNXC43cDR7spwQ4H/CQBpnG9fwyoHvClgwAGs7da9fnw7TQgaXuXBFpjNCUWXdXul4Xdus8yLXlaDOYkMd3AFvtnJj20OTNFMXABXrhfJqzINcmi0Pj+8Mn0u9XPZYy3adzowUZYuqnHc9JAN8rx6G1pTeqYUUNhbQRDTdZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbV80vqH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso20249261fa.3;
        Fri, 30 May 2025 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748621698; x=1749226498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UTq5HkLhV23M0xz/nleVLoMMJCEzvqCvQMrpj98LYs=;
        b=JbV80vqHwel8CwcWdxj45VZ8VKN6Mu7Kus7OyUpXAoGS9EZvUFIWQZCSjBUyqgW4Yp
         XZtg8XjUqZ75yJobNEH44YELYhKlP1tfyKkd9n1Un0c6Yp8mVfC8P/O2MiNOjq/fdYH7
         WcfxOeSzJgoiQldJtn3rLocQDZoYfg74g2ieSrivQqg9x7O12F8FlZedg3tQnvouSYHC
         hokM+VJI+ZnR3sDF2TDzFyxmfjW+cLlpCT0D65zJ/Ua+yjGXXM75xaQciqb6AwLOsT6u
         4vUqnQhvtI+Lg0QB9cmNuC6RHXwmmv2cJ0Ijs5J+HTkFNRSOEGS8xcvu5C02jK6zQ6SN
         dN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748621698; x=1749226498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UTq5HkLhV23M0xz/nleVLoMMJCEzvqCvQMrpj98LYs=;
        b=HUUyCyBkOGop2XKjZmSgT8C+OZaCu1j2OboVMtrbRfz45nw4i0A9S8gHTmZuAmCih6
         5VweDU60t1wrCe3BU8CREkvCvddnyxEec35z1O82C9cXbWBzPkB3khNdwRR0Q1uRORBf
         47Um5isQOmj+2NOUUpEYqvw0zy/h8DxttwsMTCUnQmrSNnemujkmEUycN35tepfh3+lU
         pl5FsdVGkNT6Kn0zEMeIxSFmycMA38LM9akp2u3GfgGTBjyQgyDZrbMLulnQKrvqoZDg
         MdslS4IR5gAz9B35dAeQ5ppvOeGF9RSkoYoQuNfME64v/BrV68KFT68Wlaym/GF/549s
         BRdw==
X-Forwarded-Encrypted: i=1; AJvYcCVUI1TbwI2h1d3qU4AH2ZEWOaTnORLEcCuCRUdq3hZgsQfqHTnJYFq3Fixxvm/Xri5OZofLAWPJ6v/B@vger.kernel.org, AJvYcCVjL5U0Yzo2P0UrdV08AFpU/GlTAnQNzeJfjPz/fi3NN/TsbCp9rgvrp5s8Zy5X6ntVkppxNYcX4wnceyUAgA==@vger.kernel.org, AJvYcCWy0EYfDGwH34jLiJDxANydoLEG5F3L1pF3as7WgwqCdw0X+txJdNst0/k3+6ostQS0/7HO/kgIxQ8S6wPp@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCzoQRuZ8WiYqSkR8BrLvhvnTBxf4rY3giX1+dD+ZKfm5OMQo
	YOOujoCbHW8UUsOl7q79n8HbWQQLs+NDEmjyzrCzDWsBO2tByPh9rix+xdwBwwEb3Mow80KsGMr
	pdmwyq6mergBSr0UNKtO1ot38DLIMmWE=
X-Gm-Gg: ASbGncuSS5x1jgtLuGe9RpjU1qP10etZRkc+teB2hz/JUEE5qYNk0V5x1HYX4NcKbqI
	e21dJk/9JztG/6ajsyD+MZanDSYzVyKAlH22vJd3y9+MRxZPU31/rvlf6PV0MTvLClPkHOdVWwx
	VglsMs20F4NeV+chKOla1DHAeKWH3tJXJdHRb6XKCfOJ91y4HNR32dvVJ1zBsTCD2UZyU=
X-Google-Smtp-Source: AGHT+IG/NJcvokzMVAfgAUULPo5AHEfz55/2Xhz/gGIFl6PSQ86+UbqO3pGexblTmnbk2F682gpMuOlFZAHMLwVuv8c=
X-Received: by 2002:a05:651c:509:b0:32a:8062:69b1 with SMTP id
 38308e7fff4ca-32a9068a6f6mr12904441fa.8.1748621697994; Fri, 30 May 2025
 09:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530084614.2434467-1-frank.li@vivo.com>
In-Reply-To: <20250530084614.2434467-1-frank.li@vivo.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 30 May 2025 11:14:45 -0500
X-Gm-Features: AX0GCFtGHmv3izUG2w7WT1FVlkS5ZFbMOTfhnGBK58yTeSsKAU5O4zE_8tf3tkU
Message-ID: <CAH2r5msAq6Kq4R0euj+y526imrsGWcXLa_LCJ9T+8G2-9PJx6A@mail.gmail.com>
Subject: Re: [PATCH] cifs: correct superblock flags
To: Yangtao Li <frank.li@vivo.com>
Cc: pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	tom@talpey.com, bharathsm@microsoft.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> SB_NOATIME includes SB_NODIRATIME as a subset. Therefore, setting SB_NOAT=
IME is sufficient

Although technically the flag is not a subset, with current code in
atime_needs_update() setting SB_NODIRATIME is not needed if SB_NOATIME
is already set (see below), but it could be argued that the code is
clearer (easier to understand) to set both flags (especially as it has
no performance hit), and multiple other fs also do this. Any
additional thoughts?

        if (IS_NOATIME(inode))
                return false;
        if ((inode->i_sb->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode=
))
                return false;h


On Fri, May 30, 2025 at 3:25=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:
>
> SB_NOATIME includes SB_NODIRATIME as a subset. Therefore,
> setting SB_NOATIME is sufficient to disable atime updates
> for all files and directories.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/smb/client/cifsfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index a08c42363ffc..b4bc15ea33bf 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -996,7 +996,7 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
>         mnt_data.flags =3D flags;
>
>         /* BB should we make this contingent on mount parm? */
> -       flags |=3D SB_NODIRATIME | SB_NOATIME;
> +       flags |=3D SB_NOATIME;
>
>         sb =3D sget(fs_type, cifs_match_super, cifs_set_super, flags, &mn=
t_data);
>         if (IS_ERR(sb)) {
> --
> 2.48.1
>
>


--
Thanks,

Steve

