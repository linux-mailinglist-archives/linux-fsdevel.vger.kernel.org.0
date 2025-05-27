Return-Path: <linux-fsdevel+bounces-49936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E98AC5D2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 00:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093CF3A54DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEFF216E1B;
	Tue, 27 May 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="d5s+Qbk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570C1F1905
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385379; cv=none; b=l8Q+wGIZfp02dGBUxY4ubUggl2vH5uyHxlThn2D4ob36afdn3+GZMshc4m4ZDMy/TI4ivItnzypaDQbODU2tFko3bchnMpmvkEpzimoA1qB5GrsF5Vj1bECQ7nfqIUa9hg26T+n/WlKpzfHBE53Ef/Jjr3n2PHDoz2KksD5JWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385379; c=relaxed/simple;
	bh=40TT6223RMHNBfkiH6pSJ4DCwFeYRyONDlM+ZtHOYFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTKmIHWa/fo+Wa7nJtasQN6g3PtxLFvWqyhFIH3tFr/GI1mrz/HHPxzfJk5Ye8YGF5zZwwxCUy+YIF5WvL2Di9YQM9fIvKevwH+EjY7GVoekRPzsL/6Vbhy2QV6INqGiBLBUss8oIdXKst4nIbOcVmdqqBXvUUiCBQwcgKLbfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=d5s+Qbk8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c9563fafso2746468b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1748385376; x=1748990176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=se5I//8uzLIZZ2Ua7ZTNM1QkZa6yES7oyoqw0SgUaKU=;
        b=d5s+Qbk8w3KB5HsnZiGVyMHmhmocJ3LWPIQmxX5kogA4DPnsW/23M8SffDLc7qmmEH
         NiyWn+7d6yT5t+ktsTPLZB0AFR6edHZerWCfr7szbFHww143eCXeF8taF0LWMAmSrcdN
         LkTtPYwWRmZPNWjkKldH248dICF/7KUE870uSiyDI+HgUSrcm7RISAN2D5h5cNL8ktPy
         hio6n/wPA3tOMqgdt72D6nq7zkb/X3+w5lIcpVzdThods73Wzj5rDKrI2uaCz04QmaON
         /qTBla11FH2SCnLJjqxGDeXeP7UOH3aHv+8mU1lC4HkJq4Ygw1sFW9q3BBM1z1G8nGKb
         rapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385376; x=1748990176;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se5I//8uzLIZZ2Ua7ZTNM1QkZa6yES7oyoqw0SgUaKU=;
        b=ZhMHe2SbT/6jT6WvDTqeo/7J9+LGbn/M28eXK7y3/3McL/2jqMRZ8YeLMLqxERBalr
         4qJBnvji57kQzGxtUIwVysu6pnWvitWOjfaDUxbWpDIxsGIuSChz4ADxEwRdX6WuSwK2
         s2M2WTkQx5zSARYffMvroHBp/jjGP60nmA55ftUv45DEomVhndRakmfccz6DAyq07cUY
         I1h1QlJCP52HHgY/lAdpIMBmZnNY1IqLxHVTJ7P8GU6lwO+H4JFUeCdab+kzHnezNBD3
         qy9YvfL7cUh8lt5UcdVxM1xlQksNIENJgDe+Zx+sRUAkfj/KKaJ0rGZ8sNHzUQMOY42r
         Pv4A==
X-Gm-Message-State: AOJu0Ywg/E8DNWnvI2B4xDMZNj5JXx9O0HpGIQNYQMvsyiyIbCMoumeW
	C5mGPQoom7bZyeDfxKHn6+C9lHv+gAQNaM96GUbakoFbU9qpQM2y9Eu+flXbVKr+8YQ=
X-Gm-Gg: ASbGnctf2LkUXy/hPDPTV+DLQ/vNw9Ox9cKe8jiFwFjdH1U58WvlBGfxfm+fTyRYT6s
	OW7Fbs5uzRgIstKZLF54eYjSLPr5y74Kv1IGYROHdY09cUHYL5hIjcFhzXVJ9NAsUMMiIFNyzQ/
	LR6xVHNhjz6hxvBhdvAQb1+3+3KLQZtoBvwxolKlDSYcwKK8kEsxDS9eXz1are5g6Y7tjhZYt+d
	vlFYAIjoNPzOxEAab3mVEVNxOwwzZWaojH9DVO+L2f5Z/fIGBEs8qUHQa2yXfUtSo85B0NqAVJN
	NS/jd+E8g9jQGe+SfU3miYEEcWlH7rq79+Ar8gcx7lGZZH+k5CaH+MfVn9FbKphcZbrU4R/IQ/l
	WYOJpo8MGi8FzqAohJFV/BcE=
X-Google-Smtp-Source: AGHT+IHaiHE641xxzDMfr1wkDbFGsdFxw8FhdTQVBDaoFZF5b72J7tD+yg5+vydr3p3YDm6cayOlWg==
X-Received: by 2002:a05:6a20:2d0c:b0:215:e60b:3bd2 with SMTP id adf61e73a8af0-2188c37d5eamr24296081637.30.1748385375862;
        Tue, 27 May 2025 15:36:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:dc04:52d5:a995:1c97? ([2600:1700:6476:1430:dc04:52d5:a995:1c97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2cc40d6ee6sm119850a12.67.2025.05.27.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 15:36:14 -0700 (PDT)
Message-ID: <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
Subject: Re: [PATCH v2 2/3] hfs: correct superblock flags
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Slava.Dubeyko@ibm.com
Date: Tue, 27 May 2025 15:36:13 -0700
In-Reply-To: <20250519165214.1181931-2-frank.li@vivo.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
	 <20250519165214.1181931-2-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 10:52 -0600, Yangtao Li wrote:
> We don't support atime updates of any kind,
> because hfs actually does not have atime.
>=20
> =C2=A0=C2=A0 dirCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of creation}
> =C2=A0=C2=A0 dirMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last modification}
> =C2=A0=C2=A0 dirBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last backup}
>=20
> =C2=A0=C2=A0 filCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of creation}
> =C2=A0=C2=A0 filMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last modification}
> =C2=A0=C2=A0 filBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last backup}
>=20
> W/O patch(xfstest generic/003):
>=20
> =C2=A0+ERROR: access time has changed for file1 after remount
> =C2=A0+ERROR: access time has changed after modifying file1
> =C2=A0+ERROR: change time has not been updated after changing file1
> =C2=A0+ERROR: access time has changed for file in read-only filesystem
>=20
> W/ patch(xfstest generic/003):
>=20
> =C2=A0+ERROR: access time has not been updated after accessing file1 firs=
t
> time
> =C2=A0+ERROR: access time has not been updated after accessing file2
> =C2=A0+ERROR: access time has changed after modifying file1
> =C2=A0+ERROR: change time has not been updated after changing file1
> =C2=A0+ERROR: access time has not been updated after accessing file3
> second time
> =C2=A0+ERROR: access time has not been updated after accessing file3 thir=
d
> time
>=20

I am slightly confused by comment. Does it mean that the fix introduces
more errors? It looks like we need to have more clear explanation of
the fix here.

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfs/super.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index fe09c2093a93..9fab84b157b4 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -331,7 +331,7 @@ static int hfs_fill_super(struct super_block *sb,
> struct fs_context *fc)
> =C2=A0	sbi->sb =3D sb;
> =C2=A0	sb->s_op =3D &hfs_super_operations;
> =C2=A0	sb->s_xattr =3D hfs_xattr_handlers;
> -	sb->s_flags |=3D SB_NODIRATIME;
> +	sb->s_flags |=3D SB_NOATIME;

I believe we need to have two flags here:

s->s_flags |=3D SB_NODIRATIME | SB_NOATIME;


Thanks,
Slava.

> =C2=A0	mutex_init(&sbi->bitmap_lock);
> =C2=A0
> =C2=A0	res =3D hfs_mdb_get(sb);

