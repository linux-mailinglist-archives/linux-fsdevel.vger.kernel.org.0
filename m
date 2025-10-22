Return-Path: <linux-fsdevel+bounces-65108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA44BFC9A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E928562810C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650A34CFAE;
	Wed, 22 Oct 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs9xo/N3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECD34C145
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143277; cv=none; b=esnDuGdecNO7mbqcg6xsW1h6LfO/qb3lfZ6iXNFmUZqRzzh+odoBER8qAB9e9R4TTA8WKZYNm256a0nrFhoupIC1smnyVUpNVQKRts8MUr0/FpH80Cg669CaY6SEsV+2iRRV4X0IFNQkBsK4/mtnJtaEOOEsOaR8ts0U2kp/8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143277; c=relaxed/simple;
	bh=WVOgL7DSeXLQFb5/H8c6hB/Dce4q3SRBT0tEBnY07j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIX98U6rKBJTJeqdbZ+GIuTTD237uteJL+8tnObON2UIGZgwfNUiJ0tfSU2KT+fWVE1nv7YghP0Q+WRQGtm2o3EIP8VJAPQFBVOMgQpH6lAe227r9t484pEA98HEvcYItFwsDqByADXlTi7Id8AyA5EBOdc2VCX4WcYTxvliv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs9xo/N3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so13060636a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761143274; x=1761748074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB4qyF9K6CdJEV+K0I5ZXCME5hmS1ZafgIHkTOqJR2Y=;
        b=Vs9xo/N3XxZFJtA2qlxgskHb06oi2SCEHaOAeJINUvSjFpnftsVlfYgZwp2bpPNeeb
         epMjqGvkkhkM8bJd2bYcjHN8iYPCrVvvoztL/k6ncEyxP+LjlkMgpuGGnaVsFAb0hrR1
         69d+q3d1noQb6CVflD76Hl3z3qRneRaQ1gwtJ+nRnM6C9dyzfpROC8CAC9g63DX8l5Rb
         49wPWftc99bHhD8aI6nqHNc+yCcXMzpfxR1mr4P9E/vVZv4fgvOQ4+WPtzobw4/r9wz8
         DiNbFNls7WBq4AFC3LYDLDfr4FQ9AiBF0sOMCX6g79dlknDTQuIEix1OqWfstyTbLhrZ
         U/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143274; x=1761748074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lB4qyF9K6CdJEV+K0I5ZXCME5hmS1ZafgIHkTOqJR2Y=;
        b=QCeYbK82pntEeI4aor5JRgnTlXtSmzpaKq5XtRwTzdxwNpdycn2UU1sLUvWdgusF9n
         dNwciD80tsAHy73gmbdQRCOSrumJu2c26KUsQz47rvllkYtqnPHQxTv96n6MYxM0F2Ao
         +9d/QvTFaLKRY8migUE+Ji5u70cl/V+GPCsFVpdvCcCSlejyyg4t15qv49aqni1BXxO3
         b9sGpgHVYSCXU6nvKWnKgRaH5yLoABokgz0iXzH50rnXzFg72FV6xuUIhf1IV9BmBnat
         24z7J4JL85IF9YoiQV+fJ7tpIM/CzGG0fV2aNQ8hO13lobAps+t42Fy20rDvV6iB6pjI
         d+1g==
X-Forwarded-Encrypted: i=1; AJvYcCU7/EV7iOuE6uS0fQCumLwahBG1OvK4xFWE41Ele6KE+3wo68VNmMeMCcaeBKFTMhhQFVcrNjzSINjh3i0v@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa+n18/qys3plIS0VASIYW25AwePo4DEfj8M2to7WN0OX6DIw
	u5K8GEx4icfurlfTC5soW3iW42aqKjAoe4iXeEtQvZyW+nnVZbrEIE7+nSQo54Knj2yHq6UQ0Ut
	3a1FdSfFuA9/7yI9RmORWbV4SIj7z6KQ=
X-Gm-Gg: ASbGncvacdxq6d/kihx9CZVREeaJulPY/uKhIuv22+Oa9ehBre5hD67iW8iwqfuv/m1
	auqmfqMFF0LzEu/PezLAEsh1SUX3q7XZrPfp2iGhBxk42qCU7TdJf3JS2zBHqdzLghIkfyLJt8C
	ffumel68QovZeCHp5GTyPlEp6YKKWn7VeU7ghBKXTgx0gx/b/HrR4KDOJu3VfgGkMV5jlTtyLi4
	Y9/bDUwYkLNCmWAlyw7VQqQlMDDzAVXwTOfH/iMvMoTqBGKjKT5ycxksb9slS0sjGjH8/rlZBDB
	4wCxgZb2OCZHtXPAL20=
X-Google-Smtp-Source: AGHT+IF+yjUcO1EIgPhw+/mNgUYMvzWOF9qoGmoBdRNVwdzqd1YK/UMasOSYnxP+01bg4vKVoVuFDexibelKqoaev+k=
X-Received: by 2002:a05:6402:5109:b0:63e:d75:bec4 with SMTP id
 4fb4d7f45d1cf-63e0d75c034mr4941279a12.30.1761143273610; Wed, 22 Oct 2025
 07:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022044545.893630-1-neilb@ownmail.net>
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Oct 2025 16:27:42 +0200
X-Gm-Features: AS18NWAh7v3miPrMAuvadGg7i7iVuRMT8CaQwPyaMFsqHIpC82nKeksR5dfiCpM
Message-ID: <CAOQ4uxjH4G6JrhnhLRRHAG8HBb-Dy9BcQCLs=pWz8W9t8eOvJQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Create and use APIs to centralise locking for
 directory ops.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:47=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> following is v3 of this patch set with a few changes as suggested by Amir=
.
> See particularly patches 06 09 13
>
> Whole series can be found in "pdirops" branch of
>    https://github.com/neilbrown/linux.git

Thanks for the test branch.

Besides the NULL pointer deref bug in patch 11, the overlay fstests < 100
pass, but the unionmount-testsuite tests triggers a few dentry leaks:

You'd see them if you run the overlayfs fstests overlay/1??
See README.overlay how to set unionmount-testsuite.

Here is a report of the individual test cases that leak dentries:

# cd .../unionmount-testsuite/
# mkdir -p /base /mnt
# ./run --ov --samefs rename-new-dir
...
TEST rename-new-dir.py:161: Rename new empty dir over removed empty lower d=
ir^M
 ./run --mkdir /base/m/a/empty110-new 0755^M
 ./run --rmdir /base/m/a/empty110^M
 ./run --rename /base/m/a/empty110-new /base/m/a/empty110^M
 ./run --open-file /base/m/a/empty110 -r -d^M
TEST rename-new-dir.py:172: Rename new empty dir over removed
populated lower dir^M
 ./run --mkdir /base/m/a/empty111-new 0755^M
- rmtree /base/m/a/dir111^M
 ./run --rename /base/m/a/empty111-new /base/m/a/dir111^M
 ./run --open-file /base/m/a/dir111/a -r -E ENOENT^M
 ./run --open-file /base/m/a/dir111/pop -r -d -E ENOENT^M
 ./run --open-file /base/m/a/dir111 -r -d^M
...
[  388.752012] BUG: Dentry 00000000f4f4e4ee{i=3D19f,n=3Dempty111-new}
still in use (1) [unmount of tmpfs tmpfs]^M
...
[  388.817649] BUG: Dentry 0000000094364c21{i=3D19f,n=3Dempty110-new}
still in use (1) [unmount of tmpfs tmpfs]^M

# ./run --ov --samefs rename-new-pop-dir
...
TEST rename-new-pop-dir.py:182: Rename new dir over removed unioned empty d=
ir^M
 ./run --mkdir /base/m/a/dir112-new 0755^M
 ./run --open-file /base/m/a/dir112-new/a -w -c -W aaaa^M
 ./run --rmdir /base/m/a/dir112/pop/c^M
 ./run --rename /base/m/a/dir112-new /base/m/a/dir112/pop/c^M
 ./run --open-file /base/m/a/dir112/pop/c -r -d^M
 ./run --open-file /base/m/a/dir112/pop/c/a -r -R aaaa^M
TEST rename-new-pop-dir.py:195: Rename new dir over removed unioned
dir, different files^M
 ./run --mkdir /base/m/a/dir113-new 0755^M
 ./run --open-file /base/m/a/dir113-new/a -w -c -W aaaa^M
- rmtree /base/m/a/dir113/pop^M
 ./run --rename /base/m/a/dir113-new /base/m/a/dir113/pop^M
 ./run --open-file /base/m/a/dir113/pop -r -d^M
 ./run --open-file /base/m/a/dir113/pop/a -r -R aaaa^M
 ./run --open-file /base/m/a/dir113/pop/b -r -E ENOENT^M
TEST rename-new-pop-dir.py:209: Rename new dir over removed unioned
dir, same files^M
 ./run --mkdir /base/m/a/dir114-new 0755^M
 ./run --open-file /base/m/a/dir114-new/b -w -c -W aaaa^M
- rmtree /base/m/a/dir114/pop^M
 ./run --rename /base/m/a/dir114-new /base/m/a/dir114/pop^M
 ./run --open-file /base/m/a/dir114-new -r -d -E ENOENT^M
 ./run --open-file /base/m/a/dir114/pop -r -d^M
 ./run --open-file /base/m/a/dir114/pop/b -r -R aaaa^M
TEST rename-new-pop-dir.py:223: Rename new dir over removed unioned
dir, different dirs^M
 ./run --mkdir /base/m/a/dir115-new 0755^M
 ./run --mkdir /base/m/a/dir115-new/pop 0755^M
 ./run --open-file /base/m/a/dir115-new/pop/x -w -c -W aaaa^M
- rmtree /base/m/a/dir115^M
 ./run --rename /base/m/a/dir115-new /base/m/a/dir115^M
 ./run --open-file /base/m/a/dir115-new -r -d -E ENOENT^M
 ./run --open-file /base/m/a/dir115 -r -d^M
 ./run --open-file /base/m/a/dir115/pop/x -r -R aaaa^M
 ./run --open-file /base/m/a/dir115/pop/b -r -E ENOENT^M
...
[  424.294866] BUG: Dentry 0000000038c5d03b{i=3D1b0,n=3Ddir116-new}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  424.360470] BUG: Dentry 0000000022ebd323{i=3D1b0,n=3Ddir115-new}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  424.416038] BUG: Dentry 0000000081e7b75d{i=3D1b0,n=3Ddir114-new}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  424.483255] BUG: Dentry 00000000f7c68d9e{i=3D1b0,n=3Ddir113-new}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  424.547676] BUG: Dentry 00000000cc79d5e8{i=3D1b0,n=3Ddir112-new}  still
in use (1) [unmount of tmpfs tmpfs]^M


# ./run --ov --samefs rename-pop-dir
...
TEST rename-pop-dir.py:10: Rename dir and rename back^M
 ./run --rename /base/m/a/dir100 /base/m/a/no_dir100^M
 ./run --rename /base/m/a/dir100 /base/m/a/no_dir100 -E ENOENT^M
 ./run --rename /base/m/a/no_dir100 /base/m/a/dir100^M
 ./run --rename /base/m/a/no_dir100 /base/m/a/dir100 -E ENOENT^M
 ./run --open-file /base/m/a/dir100 -r -d^M
 ./run --open-file /base/m/a/no_dir100 -r -d -E ENOENT^M
 ./run --open-file /base/m/a/dir100/a -r^M
TEST rename-pop-dir.py:24: Rename dir and remove old name^M
 ./run --rename /base/m/a/dir101 /base/m/a/no_dir101^M
 ./run --rmdir /base/m/a/dir101 -E ENOENT^M
 ./run --rename /base/m/a/no_dir101 /base/m/a/dir101^M
 ./run --rename /base/m/a/no_dir101 /base/m/a/dir101 -E ENOENT^M
 ./run --open-file /base/m/a/dir101 -r -d^M
 ./run --rmdir /base/m/a/dir101 -E ENOTEMPTY^M
 ./run --open-file /base/m/a/dir101 -r -d^M
 ./run --open-file /base/m/a/no_dir101 -r -d -E ENOENT^M
 ./run --open-file /base/m/a/dir101/a -r^M
TEST rename-pop-dir.py:40: Rename dir and unlink old name^M
 ./run --rename /base/m/a/dir102 /base/m/a/no_dir102^M
 ./run --unlink /base/m/a/dir102 -E ENOENT^M
 ./run --rename /base/m/a/no_dir102 /base/m/a/dir102^M
 ./run --rename /base/m/a/no_dir102 /base/m/a/dir102 -E ENOENT^M
 ./run --open-file /base/m/a/dir102 -r -d^M
 ./run --unlink /base/m/a/dir102 -E EISDIR^M
 ./run --open-file /base/m/a/dir102 -r -d^M
 ./run --open-file /base/m/a/no_dir102 -r -d -E ENOENT^M
 ./run --open-file /base/m/a/dir102/a -r^M
...
[  434.158149] BUG: Dentry 00000000d2ca689c{i=3D199,n=3Dno_dir102}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  434.221809] BUG: Dentry 000000006c8e444d{i=3D197,n=3Dno_dir101}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  434.283807] BUG: Dentry 00000000e9aece78{i=3D195,n=3Dno_dir100}  still
in use (1) [unmount of tmpfs tmpfs]^M

# ./run --ov --samefs rename-empty-dir
...
TEST rename-empty-dir.py:10: Rename empty dir and rename back^M
 ./run --rename /base/m/a/empty100 /base/m/a/no_dir100^M
 ./run --rename /base/m/a/empty100 /base/m/a/no_dir100 -E ENOENT^M
 ./run --rename /base/m/a/no_dir100 /base/m/a/empty100^M
 ./run --rename /base/m/a/no_dir100 /base/m/a/empty100 -E ENOENT^M
 ./run --open-file /base/m/a/empty100 -r -d^M
 ./run --open-file /base/m/a/no_dir100 -r -d -E ENOENT^M
TEST rename-empty-dir.py:23: Rename empty dir and remove old name^M
 ./run --rename /base/m/a/empty101 /base/m/a/no_dir101^M
 ./run --rmdir /base/m/a/empty101 -E ENOENT^M
 ./run --rename /base/m/a/no_dir101 /base/m/a/empty101^M
 ./run --rename /base/m/a/no_dir101 /base/m/a/empty101 -E ENOENT^M
 ./run --open-file /base/m/a/empty101 -r -d^M
 ./run --rmdir /base/m/a/empty101^M
 ./run --rmdir /base/m/a/empty101 -E ENOENT^M
 ./run --open-file /base/m/a/empty101 -r -d -E ENOENT^M
 ./run --open-file /base/m/a/no_dir101 -r -d -E ENOENT^M
TEST rename-empty-dir.py:39: Rename empty dir and unlink old name^M
 ./run --rename /base/m/a/empty102 /base/m/a/no_dir102^M
 ./run --unlink /base/m/a/empty102 -E ENOENT^M
 ./run --rename /base/m/a/no_dir102 /base/m/a/empty102^M
 ./run --rename /base/m/a/no_dir102 /base/m/a/empty102 -E ENOENT^M
 ./run --open-file /base/m/a/empty102 -r -d^M
 ./run --unlink /base/m/a/empty102 -E EISDIR^M
 ./run --open-file /base/m/a/empty102 -r -d^M
 ./run --open-file /base/m/a/no_dir102 -r -d -E ENOENT^M
...
[  455.066208] BUG: Dentry 000000001f825e4e{i=3D19a,n=3Dno_dir102}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  455.135872] BUG: Dentry 00000000283f4586{i=3D197,n=3Dno_dir101}  still
in use (1) [unmount of tmpfs tmpfs]^M
...
[  455.193638] BUG: Dentry 0000000001271a44{i=3D195,n=3Dno_dir100}  still
in use (1) [unmount of tmpfs tmpfs]^M

Let me know if you need further help to reproduce.

Thanks,
Amir.

