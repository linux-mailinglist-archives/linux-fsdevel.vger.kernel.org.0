Return-Path: <linux-fsdevel+bounces-48476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F9AAFA3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9D5500B6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACBA227B94;
	Thu,  8 May 2025 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEG6zlNF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9E226CE4
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708057; cv=none; b=PeRQ5ur/WDcxB/nSt1Lyyat/o+AY7a7kqyts1STKrX3NZwSbJjxIds2ZKVPE0q4RdoCYu9hnin/RWxHJOr9pUg7/Qchm6p2ULWvo4AkGL6WSQwZROnQQWbuD6kUfDBLLiy8LAp5mnG6l4mosM6JPG4OHG2yG9rjD1TsRRtOmUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708057; c=relaxed/simple;
	bh=t714p2FTPXU2itEvrpjTxltqYjLasx7RT9lxrWRx+sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQLh8NUNvRodIqwFRqR2TcuVo7tWOI8i1qcJ+IUizoKBSIuLNwFmFk/GOkQ/IcI8nMZqcB8ngEojLGCSujLIip1liK6fG0mg225rsx2QIFnwpzqiI4G2uHRfAGv6sQZOVlXzKH+Mj40hadHvf3Hv0xxPM3DTn4O8xNm+qOQVs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEG6zlNF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so1445372a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 05:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746708054; x=1747312854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HPYVBkWhi2pZqy8k4gSAnqS0T9CEFZWod68KJrK3RU=;
        b=GEG6zlNF6n4DxdiCn0i3KXXBwD7f18Gjg2PhV9u3BImty3HdbJ5hUBq7BdoxwRam9u
         f0xsHqE5Tld+RoRL995/7JHkutcZngN9UFg3rjbmVFORiAIoxDj/krrv2h8voBEiS11r
         rZkEU5MXnsX6p2PeFMAu5+tB3+mrzpVlhOktxSMlS1uYI8cMOF3IaX0bhMMnsdqji9fm
         hGZDYZiLN+BnR2Z/kEQ3vRX32ob3sEgMiMiXGqdkTZ/5Rbd6/2oPoEm+BjmdTrPabfuk
         SClyWlofunLgWcWIQvacOC6merg2jXd8Dpix4ZGON5ZWBq/UGoMnKekGsJrQq20IC6Y5
         F5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746708054; x=1747312854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HPYVBkWhi2pZqy8k4gSAnqS0T9CEFZWod68KJrK3RU=;
        b=oWlT+hEg5LNV9xVGGB08kHqh5Nstwy6dNrkBCv4QgQXZub5A+gkWwlBfeVICcrWnl/
         yCwuHskbbTitN7M1RhIPp9gvRVlViOzuZW12PB9HCjOJFMh0xsMmXpL8c5LmD7OTfruI
         k2Ka290Y8oVtaHTiN+gofNe9v54fV6yVJm/2t780UWh6F5KILzLD1FrRn5iIr9lWwrjy
         ObNCUkdnYlWqH1Tggn7BlPCTdywlKziwpm/j2/p6tvwLIr7BlQFHBTPx+EH9SL2exRzW
         /xCfI1fVrDOmOLgSJvORVtFB0xLRl8LmoI+ZBTyTZD0YBdgOS0ufM+QnuDu3LDpsGvXp
         /ZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcPPhEt54U7SwBMaqWmphqRegpNJgPak/Do4V0tqGYabJZRZ8BAKMQLSqn9LDEW1rA+IEvtat1dHtTclbC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dfPnQLGVl1dROoMLk3CoXeRSJV2ZAVfc63FHl+nSRQMBI8dZ
	5DXtpEXvS5COuAiBSkGusBs2SbL/t5R+g6cSYO3L6TGXoILCgWGeIbyWbTz1kefXmfx1lZnyl2J
	JPD5zkc44RDzvo50vMhqQsN8QIjw=
X-Gm-Gg: ASbGncsvjDnGffExr7feHdb7AAvqwYrhuVEzXoijUwKbDvGjHie1Ip/MOW6VCcP+vSc
	4HDROeRLmjSRT5D4WlUPYVTNla/EcCroSJuz1+M5PawtTnm0uCuCEmuyBBBuLpEWSkgIPRETLKz
	nPp7HZEMBsbhhBSVdD7ira7NGlGU4oEOXt
X-Google-Smtp-Source: AGHT+IGDOsQ0EQFuU3U1wMUmEi8A8kunVcn3wIMadevtTwaumXDAMbVtzK93cw/gVxgc8Y49vb7okCnVFCVMCF8scxM=
X-Received: by 2002:a05:6402:350d:b0:5f6:218d:34f3 with SMTP id
 4fb4d7f45d1cf-5fc35a2d2e7mr3001529a12.28.1746708054069; Thu, 08 May 2025
 05:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507204302.460913-1-amir73il@gmail.com> <20250507204302.460913-6-amir73il@gmail.com>
In-Reply-To: <20250507204302.460913-6-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 14:40:41 +0200
X-Gm-Features: ATxdqUFIh_poCt25AfTheShRyh6NJsQxg-_97OsacTO9sHco5dLI8ftQy0QD9Dk
Message-ID: <CAOQ4uxjT=5aa9AnR9OgJZAe8btEq5QptzB3VQ7S6rPUwYcC6rQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/filesystems: create setup_userns() helper
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:43=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Add helper to utils and use it in statmount userns tests.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../filesystems/statmount/statmount_test_ns.c | 60 +----------------
>  tools/testing/selftests/filesystems/utils.c   | 65 +++++++++++++++++++
>  tools/testing/selftests/filesystems/utils.h   |  1 +
>  3 files changed, 68 insertions(+), 58 deletions(-)
>
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test=
_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> index 375a52101d08..3c5bc2e33821 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> @@ -79,66 +79,10 @@ static int get_mnt_ns_id(const char *mnt_ns, uint64_t=
 *mnt_ns_id)
>         return NSID_PASS;
>  }
>
> -static int write_file(const char *path, const char *val)
> -{
> -       int fd =3D open(path, O_WRONLY);
> -       size_t len =3D strlen(val);
> -       int ret;
> -
> -       if (fd =3D=3D -1) {
> -               ksft_print_msg("opening %s for write: %s\n", path, strerr=
or(errno));
> -               return NSID_ERROR;
> -       }
> -
> -       ret =3D write(fd, val, len);
> -       if (ret =3D=3D -1) {
> -               ksft_print_msg("writing to %s: %s\n", path, strerror(errn=
o));
> -               return NSID_ERROR;
> -       }
> -       if (ret !=3D len) {
> -               ksft_print_msg("short write to %s\n", path);
> -               return NSID_ERROR;
> -       }
> -
> -       ret =3D close(fd);
> -       if (ret =3D=3D -1) {
> -               ksft_print_msg("closing %s\n", path);
> -               return NSID_ERROR;
> -       }
> -
> -       return NSID_PASS;
> -}
> -
>  static int setup_namespace(void)
>  {
> -       int ret;
> -       char buf[32];
> -       uid_t uid =3D getuid();
> -       gid_t gid =3D getgid();
> -
> -       ret =3D unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
> -       if (ret =3D=3D -1)
> -               ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
> -                                  strerror(errno));
> -
> -       sprintf(buf, "0 %d 1", uid);
> -       ret =3D write_file("/proc/self/uid_map", buf);
> -       if (ret !=3D NSID_PASS)
> -               return ret;
> -       ret =3D write_file("/proc/self/setgroups", "deny");
> -       if (ret !=3D NSID_PASS)
> -               return ret;
> -       sprintf(buf, "0 %d 1", gid);
> -       ret =3D write_file("/proc/self/gid_map", buf);
> -       if (ret !=3D NSID_PASS)
> -               return ret;
> -
> -       ret =3D mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> -       if (ret =3D=3D -1) {
> -               ksft_print_msg("making mount tree private: %s\n",
> -                              strerror(errno));
> +       if (setup_userns() !=3D 0)
>                 return NSID_ERROR;
> -       }
>
>         return NSID_PASS;
>  }
> @@ -200,7 +144,7 @@ static void test_statmount_mnt_ns_id(void)
>                 return;
>         }
>
> -       ret =3D setup_namespace();
> +       ret =3D setup_userns();

FYI, this is a braino.
It should remain setup_namespace()

Pushed a branch to my github will all review fixes and a WIP
mount-notify-ns_test:

https://github.com/amir73il/linux/commits/fanotify_selftests/

Thanks,
Amir.

