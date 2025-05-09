Return-Path: <linux-fsdevel+bounces-48538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF21AB0B7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B841BC1FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681F726FDBA;
	Fri,  9 May 2025 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHV3fg07"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F526AAAE;
	Fri,  9 May 2025 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775244; cv=none; b=SFWlvbmd4ce6s1Z9ubf7kG17K/ZJfT9qV0yI/mdd/RaYWpDQy3akTR0v4sRnowEzHtHnsf0DHhP2oD0fhEJLRxtCO0k8LZ4uSoKpele6TY4RopnTPcV3PHTpw1kquk0MQdlzWxkVS4hMJOg68hT9Jt8aNRqjWxNQtYFAlG2gJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775244; c=relaxed/simple;
	bh=LCin9QMurqszoVa8nmGgtDSKdrsw3cF/aGmoQNfc6tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acBR+A9KEEanGyCoVC3budRYGPc1rR1tbYaOlxMVJvYF5qYRnq+3nKXrcgXvq22S+OFzSV34tn3RnAqsTgsFKDeraMotQWnXxsqtyj2o/I7yAsznugckqs/KLQ58uWQZ+Q/J+/WRkrXOYEC0HQovxl8wRRJSnTWx0EvBrxf5rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHV3fg07; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb5ec407b1so300785766b.1;
        Fri, 09 May 2025 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746775241; x=1747380041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sDz3QKYpGwAxmXA5AboWC0JFHM3ow5nmHY1DDiphvs=;
        b=OHV3fg074eQN6WRuhN0pJECfLTAm6TQTgGM5eMO1spJdbB98+9H8Rq7mZpSQRZvbyp
         6XLfHfvrRpNVEKqm5d/yKvWwK6OdLa78jGtEOEyD0svNnzT8NTp1kmTVu9SQJQCqnk9I
         JIXeqNHfJNt67P+bD9uBQL1qXa59Ngi1KpfCdLxTjbvpll/2jFZM+FwSMHfmei/MUJlU
         3TFuIeqztFUn/lbF+r+jZF3529sXXAQBQHSdQBdkpT1KPCE+Nx5A8Bf7dhgPh0GCZ7Nz
         mm49qwcclfSJ2MH/pr12sVeYwjv1TVJVEeSRMEsOm2bBRR5jGgjXV2y2S7SCZ4Fr/6G5
         EnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746775241; x=1747380041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sDz3QKYpGwAxmXA5AboWC0JFHM3ow5nmHY1DDiphvs=;
        b=H0OppJMMkx3qT/ektsDzGnsQbJxb2qsE0l6ZqS7i+0w9yZxd0RPH3gAj/RAfh5Fd8r
         WssEzBAE/oxWu0q+LL1ybPeYUSXXKJK0qzU4JAtUbfFjslVmyMcmkloMrC3MGwidv6df
         SdwTWfrSXaiOX6oaDtBQeDbsabzR3gaxR7WmTkiLQVrM9eTvnKTxl0P1kVqInrF2msvH
         02dZHM/K1YYRF8z++8JfOzQVBw7TVoLZSfXmNoooA9S8giTvB/M+Pkj4WkT9uay91zXf
         rlFHwTP4a11aexeL+nU75vNjaDs2joW+Z9D4yHSoHj4TNZyXJSYbjq9a0rR0WifQjCA/
         bSYA==
X-Forwarded-Encrypted: i=1; AJvYcCU1rsEQqHWY1e5388Itjr7iH+M7s+zoRcieH5kyKK/+R4hxesng/yP5gHk/U/chRL5Keo+xmBA3g+rSrKpU@vger.kernel.org, AJvYcCWVPLvL7ugTK/oiLh9vnjrQoqoSKNJBKNYa6hbJz5vtsFILWPVZuztuW+wrW9hqcD/WtMHwF8I/awRalmq5@vger.kernel.org
X-Gm-Message-State: AOJu0YzxWfpJa2UinqyP33YLM/LW5SdC4WADJu8jFgswQz/AbFB6pq7o
	ZCIBfvHDAz3iykEFenM/IDaP0DyUg+VVvSho1ireweT+eIBR9pec1EH9vBj2D6J1NSIEX6laoq3
	NVWZS6UxLAEM9t/SC0VrfeD1ArhVfB9aam3bvRw==
X-Gm-Gg: ASbGncvD4MVJ6XKXTFJVVAG0gA5By24jYU79JS7c9CjbSikWN9Ww4SqFQOjGXc6JFgO
	lYr5ftPV+ZMJrZaAGiyyfedvGq9LL9cghXoN47BevUREk85Rc02YvVUy1IQGTHosG2V10BdvwRo
	Z95wcz+E3ugW8JjTg3TcxEcQ==
X-Google-Smtp-Source: AGHT+IGYw+qCYvkMDPaJozX0lv/veDPACtLbQQF/EVWtO05cEA8cOXZKGzw+JAs16qdH5r+Wi269BniuMK0/MwC17Uc=
X-Received: by 2002:a17:907:3f91:b0:ac7:805f:905a with SMTP id
 a640c23a62f3a-ad218fa14cdmr219421366b.28.1746775240961; Fri, 09 May 2025
 00:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com> <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 09:20:30 +0200
X-Gm-Features: ATxdqUFh6N-fDKy-wqu0GCk6TPtCnA8M2mH-wJCreI-a2bzUAoQyVA-JBPnJxeo
Message-ID: <CAOQ4uxhuD0QF16jbYPqnoAUQHGw_ab3wi0ZONHVTXjCh0fug-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:34=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
>
> Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
> that exposes the paths of all backing files currently being used in
> FUSE mount points. This is particularly valuable for tracking and
> debugging files used in FUSE passthrough mode.
>
> This approach is similar to how fixed files in io_uring expose their
> status through fdinfo, providing administrators with visibility into
> backing file usage. By making backing files visible through the FUSE
> control filesystem, administrators can monitor which files are being
> used for passthrough operations and can force-close them if needed by
> aborting the connection.
>
> This exposure of backing files information is an important step towards
> potentially relaxing CAP_SYS_ADMIN requirements for certain passthrough
> operations in the future, allowing for better security analysis of
> passthrough usage patterns.
>
> The control file is implemented using the seq_file interface for
> efficient handling of potentially large numbers of backing files.
> Access permissions are set to read-only (0400) as this is an
> informational interface.
>
> FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate the
> additional control file.
>
> Some related discussions can be found at links below.
>
> Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@fa=
stmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_53=
WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---

Looks good!
With minor nits fixed, please feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
(instead of Cc:)

...

>  static const struct fs_context_operations fuse_ctl_context_ops =3D {
> -       .get_tree       =3D fuse_ctl_get_tree,
> +       .get_tree =3D fuse_ctl_get_tree,
>  };
>
>  static int fuse_ctl_init_fs_context(struct fs_context *fsc)
> @@ -358,10 +489,10 @@ static void fuse_ctl_kill_sb(struct super_block *sb=
)
>  }
>
>  static struct file_system_type fuse_ctl_fs_type =3D {
> -       .owner          =3D THIS_MODULE,
> -       .name           =3D "fusectl",
> +       .owner =3D THIS_MODULE,
> +       .name =3D "fusectl",
>         .init_fs_context =3D fuse_ctl_init_fs_context,
> -       .kill_sb        =3D fuse_ctl_kill_sb,
> +       .kill_sb =3D fuse_ctl_kill_sb,
>  };

Please undo these whitespace changes.

Thanks,
Amir.

