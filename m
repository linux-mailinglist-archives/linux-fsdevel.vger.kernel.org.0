Return-Path: <linux-fsdevel+bounces-65539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44EC07691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C8C1C43B21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5423337BBF;
	Fri, 24 Oct 2025 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKu9FYdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51175272805
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324944; cv=none; b=X7adheB1qM0TYQKvhR8zDyrxf9sB0lkMEvbDJ8OoOJlkk6h4Gh4cv9/gZ54/jgxWYrNbatMxvdy96EEXzyZ/YxGZDR6wmJuTW0zF/7fACxPjJt2uk6GW/NdAQds67aqQ7Xf0ofboYx+qlM/eVGZ3fuGP+Fb8ahhXOkt5qGQWeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324944; c=relaxed/simple;
	bh=IJ67J6jTPGDZ24MDuX6oveeVnwvqB0T4gqOQ6EZ0ELY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB7KnNQYQkg4LPrbq9zoOF8bQ3tS+ezOOghdwmXDtA9hJw2H/uEaxstaCfqpQYsWSXHOnw73lM9d8RHfSknP/CMVBh+v4Q73viYF3Pg4kijrApAb8EplzYT23XLNboQJbWMUkDGzAQMpoZfIPzaCv+RacHzcV1shWn/KgLB6JOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKu9FYdr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso3931330a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761324940; x=1761929740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUJ6GHWskUudXuBHrFElse2PfnoNVMmsNBsqag8F9BY=;
        b=cKu9FYdrfg7YvJeNmZHMbCrX9S4GhAsGXIkGWkNmmARUUldsnNXHN3jIY8MhJd5kDI
         56mGta7vn6kv9/OeSh2Yg9b9tHS249l+aGHM0MXkdOYltylU9Cet2BxrPc8FpecrJS0P
         Q39h6qVgHeg8xMdDtOZ/KTG+9I31hP2HusQIfRsIoJXMy30vvau8wFKP2thYDQFWhRtH
         j92+zMVOwX450MuUjhr+Jaw/R1HfIB1EU/WfP2aGiqmtdofXqmT4Uhn27FwUajskmOJ/
         YFKrYI3kc51wHOFVhG0gVVsbc7ZWBLICiDDORp8n36QrAessdeTfKBSsUy1+ce7aCyXo
         SW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324940; x=1761929740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUJ6GHWskUudXuBHrFElse2PfnoNVMmsNBsqag8F9BY=;
        b=sr83iZ/eHnCfH6IFQtsd/pPRhOemYZY8Dcrd6CmflcwlOayh4ormusYLKOg8qH6cRD
         oj/Z92vbIPr36ud2Wy86PeU9ZtpL6bAs01OOBrwFBRDOUCuPVtYofX1vUz5DODnE12dp
         iW+A4Kwu2akzhOpu06434dF3+I8D8xaB/QfyfprWjPa4xzdzd7JswvVhD+4u82z8NmEi
         tXKGrklTna1z7VeWNATgcdY8CETXL5zr4+5FH7UtrZIiKVe/iOLYfrLgkFLGnls5wx34
         vzgcdldQN5QmRQtaF+W9s577cw5k8EYE33VgG8khmgeXASpW09YsILIK5nZV0sz45NNN
         GJsw==
X-Forwarded-Encrypted: i=1; AJvYcCUE6jTipCCSR4PI5blg/r7WSFEUQ7JQIR/O4RBhkqrqxv4NB2nRxpjdNipBHQcPOEIhQIms0KwdCxy8Ezri@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZqDoNTDpFDUeelIa6a2EBLCOzmuljh/6pAugDPvdH0DmFFiV
	Wi/pLTuRFldT0enqCO2h/AzCwfQEPJP2Y5UlOnZbxq93k3VTgFeMYPlqrfzJSM+iyjjsKgPNr6X
	zgW4yDV0eTb81td8AdyghTfmRcMyONgA=
X-Gm-Gg: ASbGncvON/pAZIBXDJLtusw7YV9yNmIcD8NxTZRW6OLM+KSStXa4lSMW8uqOtQzH7V8
	7KjTU9Pgfu3yfIJGV8hgBRhgFvQCFux//8xbFhg6yMR7++FsdTovufFaEO+Vl9/dMscNOWP7Pz4
	VA58bZGe2WRqEQdz5yP/CyOxh4RzjpOBSd6iiOHzpP6BHOUfH3zvP17pCNP3CZk3iCar8lZccGS
	MxR/6fdUmUcd4Ff+mRIRJ0rUwdQSaMBFnVzQMJ9W/wvKBB/OSk/PD3RuEIVs5ifuC5/t0YLfUsH
	HYrF9grmtKtuqTrPOMH68oRq++NMgg==
X-Google-Smtp-Source: AGHT+IH6UG3ynzY6MQQZS9eEqOiyEOUOfQWPI2lRPRTme3cJYySvdIgDlPzlBJwjMLF5zv6xjW6d3j6vCFOSZaUWlPE=
X-Received: by 2002:a05:6402:1ed2:b0:63c:276b:1504 with SMTP id
 4fb4d7f45d1cf-63c276b1683mr27357501a12.19.1761324940374; Fri, 24 Oct 2025
 09:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022044545.893630-1-neilb@ownmail.net> <CAOQ4uxjH4G6JrhnhLRRHAG8HBb-Dy9BcQCLs=pWz8W9t8eOvJQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjH4G6JrhnhLRRHAG8HBb-Dy9BcQCLs=pWz8W9t8eOvJQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Oct 2025 18:55:28 +0200
X-Gm-Features: AWmQ_bnvzT5Pc-ot0kz4PDZ5QlEzhSODYW2uW1okndD7a_KECB8DKETxeU016-o
Message-ID: <CAOQ4uxi_sAHkgn7Ob0XOatR8N+VVjD-qPE-Cfhwgas0nrxPF2w@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Create and use APIs to centralise locking for
 directory ops.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 6:47=E2=80=AFAM NeilBrown <neilb@ownmail.net> wro=
te:
> >
> > following is v3 of this patch set with a few changes as suggested by Am=
ir.
> > See particularly patches 06 09 13
> >
> > Whole series can be found in "pdirops" branch of
> >    https://github.com/neilbrown/linux.git
>
> Thanks for the test branch.
>
> Besides the NULL pointer deref bug in patch 11, the overlay fstests < 100
> pass, but the unionmount-testsuite tests triggers a few dentry leaks:
>
> You'd see them if you run the overlayfs fstests overlay/1??
> See README.overlay how to set unionmount-testsuite.
>
> Here is a report of the individual test cases that leak dentries:
>
> # cd .../unionmount-testsuite/
> # mkdir -p /base /mnt
> # ./run --ov --samefs rename-new-dir
> ...
> TEST rename-new-dir.py:161: Rename new empty dir over removed empty lower=
 dir^M
>  ./run --mkdir /base/m/a/empty110-new 0755^M
>  ./run --rmdir /base/m/a/empty110^M
>  ./run --rename /base/m/a/empty110-new /base/m/a/empty110^M
>  ./run --open-file /base/m/a/empty110 -r -d^M
> TEST rename-new-dir.py:172: Rename new empty dir over removed
> populated lower dir^M
>  ./run --mkdir /base/m/a/empty111-new 0755^M
> - rmtree /base/m/a/dir111^M
>  ./run --rename /base/m/a/empty111-new /base/m/a/dir111^M
>  ./run --open-file /base/m/a/dir111/a -r -E ENOENT^M
>  ./run --open-file /base/m/a/dir111/pop -r -d -E ENOENT^M
>  ./run --open-file /base/m/a/dir111 -r -d^M
> ...
> [  388.752012] BUG: Dentry 00000000f4f4e4ee{i=3D19f,n=3Dempty111-new}
> still in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  388.817649] BUG: Dentry 0000000094364c21{i=3D19f,n=3Dempty110-new}
> still in use (1) [unmount of tmpfs tmpfs]^M
>
> # ./run --ov --samefs rename-new-pop-dir
> ...
> TEST rename-new-pop-dir.py:182: Rename new dir over removed unioned empty=
 dir^M
>  ./run --mkdir /base/m/a/dir112-new 0755^M
>  ./run --open-file /base/m/a/dir112-new/a -w -c -W aaaa^M
>  ./run --rmdir /base/m/a/dir112/pop/c^M
>  ./run --rename /base/m/a/dir112-new /base/m/a/dir112/pop/c^M
>  ./run --open-file /base/m/a/dir112/pop/c -r -d^M
>  ./run --open-file /base/m/a/dir112/pop/c/a -r -R aaaa^M
> TEST rename-new-pop-dir.py:195: Rename new dir over removed unioned
> dir, different files^M
>  ./run --mkdir /base/m/a/dir113-new 0755^M
>  ./run --open-file /base/m/a/dir113-new/a -w -c -W aaaa^M
> - rmtree /base/m/a/dir113/pop^M
>  ./run --rename /base/m/a/dir113-new /base/m/a/dir113/pop^M
>  ./run --open-file /base/m/a/dir113/pop -r -d^M
>  ./run --open-file /base/m/a/dir113/pop/a -r -R aaaa^M
>  ./run --open-file /base/m/a/dir113/pop/b -r -E ENOENT^M
> TEST rename-new-pop-dir.py:209: Rename new dir over removed unioned
> dir, same files^M
>  ./run --mkdir /base/m/a/dir114-new 0755^M
>  ./run --open-file /base/m/a/dir114-new/b -w -c -W aaaa^M
> - rmtree /base/m/a/dir114/pop^M
>  ./run --rename /base/m/a/dir114-new /base/m/a/dir114/pop^M
>  ./run --open-file /base/m/a/dir114-new -r -d -E ENOENT^M
>  ./run --open-file /base/m/a/dir114/pop -r -d^M
>  ./run --open-file /base/m/a/dir114/pop/b -r -R aaaa^M
> TEST rename-new-pop-dir.py:223: Rename new dir over removed unioned
> dir, different dirs^M
>  ./run --mkdir /base/m/a/dir115-new 0755^M
>  ./run --mkdir /base/m/a/dir115-new/pop 0755^M
>  ./run --open-file /base/m/a/dir115-new/pop/x -w -c -W aaaa^M
> - rmtree /base/m/a/dir115^M
>  ./run --rename /base/m/a/dir115-new /base/m/a/dir115^M
>  ./run --open-file /base/m/a/dir115-new -r -d -E ENOENT^M
>  ./run --open-file /base/m/a/dir115 -r -d^M
>  ./run --open-file /base/m/a/dir115/pop/x -r -R aaaa^M
>  ./run --open-file /base/m/a/dir115/pop/b -r -E ENOENT^M
> ...
> [  424.294866] BUG: Dentry 0000000038c5d03b{i=3D1b0,n=3Ddir116-new}  stil=
l
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  424.360470] BUG: Dentry 0000000022ebd323{i=3D1b0,n=3Ddir115-new}  stil=
l
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  424.416038] BUG: Dentry 0000000081e7b75d{i=3D1b0,n=3Ddir114-new}  stil=
l
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  424.483255] BUG: Dentry 00000000f7c68d9e{i=3D1b0,n=3Ddir113-new}  stil=
l
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  424.547676] BUG: Dentry 00000000cc79d5e8{i=3D1b0,n=3Ddir112-new}  stil=
l
> in use (1) [unmount of tmpfs tmpfs]^M
>
>
> # ./run --ov --samefs rename-pop-dir
> ...
> TEST rename-pop-dir.py:10: Rename dir and rename back^M
>  ./run --rename /base/m/a/dir100 /base/m/a/no_dir100^M
>  ./run --rename /base/m/a/dir100 /base/m/a/no_dir100 -E ENOENT^M
>  ./run --rename /base/m/a/no_dir100 /base/m/a/dir100^M
>  ./run --rename /base/m/a/no_dir100 /base/m/a/dir100 -E ENOENT^M
>  ./run --open-file /base/m/a/dir100 -r -d^M
>  ./run --open-file /base/m/a/no_dir100 -r -d -E ENOENT^M
>  ./run --open-file /base/m/a/dir100/a -r^M
> TEST rename-pop-dir.py:24: Rename dir and remove old name^M
>  ./run --rename /base/m/a/dir101 /base/m/a/no_dir101^M
>  ./run --rmdir /base/m/a/dir101 -E ENOENT^M
>  ./run --rename /base/m/a/no_dir101 /base/m/a/dir101^M
>  ./run --rename /base/m/a/no_dir101 /base/m/a/dir101 -E ENOENT^M
>  ./run --open-file /base/m/a/dir101 -r -d^M
>  ./run --rmdir /base/m/a/dir101 -E ENOTEMPTY^M
>  ./run --open-file /base/m/a/dir101 -r -d^M
>  ./run --open-file /base/m/a/no_dir101 -r -d -E ENOENT^M
>  ./run --open-file /base/m/a/dir101/a -r^M
> TEST rename-pop-dir.py:40: Rename dir and unlink old name^M
>  ./run --rename /base/m/a/dir102 /base/m/a/no_dir102^M
>  ./run --unlink /base/m/a/dir102 -E ENOENT^M
>  ./run --rename /base/m/a/no_dir102 /base/m/a/dir102^M
>  ./run --rename /base/m/a/no_dir102 /base/m/a/dir102 -E ENOENT^M
>  ./run --open-file /base/m/a/dir102 -r -d^M
>  ./run --unlink /base/m/a/dir102 -E EISDIR^M
>  ./run --open-file /base/m/a/dir102 -r -d^M
>  ./run --open-file /base/m/a/no_dir102 -r -d -E ENOENT^M
>  ./run --open-file /base/m/a/dir102/a -r^M
> ...
> [  434.158149] BUG: Dentry 00000000d2ca689c{i=3D199,n=3Dno_dir102}  still
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  434.221809] BUG: Dentry 000000006c8e444d{i=3D197,n=3Dno_dir101}  still
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  434.283807] BUG: Dentry 00000000e9aece78{i=3D195,n=3Dno_dir100}  still
> in use (1) [unmount of tmpfs tmpfs]^M
>
> # ./run --ov --samefs rename-empty-dir
> ...
> TEST rename-empty-dir.py:10: Rename empty dir and rename back^M
>  ./run --rename /base/m/a/empty100 /base/m/a/no_dir100^M
>  ./run --rename /base/m/a/empty100 /base/m/a/no_dir100 -E ENOENT^M
>  ./run --rename /base/m/a/no_dir100 /base/m/a/empty100^M
>  ./run --rename /base/m/a/no_dir100 /base/m/a/empty100 -E ENOENT^M
>  ./run --open-file /base/m/a/empty100 -r -d^M
>  ./run --open-file /base/m/a/no_dir100 -r -d -E ENOENT^M
> TEST rename-empty-dir.py:23: Rename empty dir and remove old name^M
>  ./run --rename /base/m/a/empty101 /base/m/a/no_dir101^M
>  ./run --rmdir /base/m/a/empty101 -E ENOENT^M
>  ./run --rename /base/m/a/no_dir101 /base/m/a/empty101^M
>  ./run --rename /base/m/a/no_dir101 /base/m/a/empty101 -E ENOENT^M
>  ./run --open-file /base/m/a/empty101 -r -d^M
>  ./run --rmdir /base/m/a/empty101^M
>  ./run --rmdir /base/m/a/empty101 -E ENOENT^M
>  ./run --open-file /base/m/a/empty101 -r -d -E ENOENT^M
>  ./run --open-file /base/m/a/no_dir101 -r -d -E ENOENT^M
> TEST rename-empty-dir.py:39: Rename empty dir and unlink old name^M
>  ./run --rename /base/m/a/empty102 /base/m/a/no_dir102^M
>  ./run --unlink /base/m/a/empty102 -E ENOENT^M
>  ./run --rename /base/m/a/no_dir102 /base/m/a/empty102^M
>  ./run --rename /base/m/a/no_dir102 /base/m/a/empty102 -E ENOENT^M
>  ./run --open-file /base/m/a/empty102 -r -d^M
>  ./run --unlink /base/m/a/empty102 -E EISDIR^M
>  ./run --open-file /base/m/a/empty102 -r -d^M
>  ./run --open-file /base/m/a/no_dir102 -r -d -E ENOENT^M
> ...
> [  455.066208] BUG: Dentry 000000001f825e4e{i=3D19a,n=3Dno_dir102}  still
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  455.135872] BUG: Dentry 00000000283f4586{i=3D197,n=3Dno_dir101}  still
> in use (1) [unmount of tmpfs tmpfs]^M
> ...
> [  455.193638] BUG: Dentry 0000000001271a44{i=3D195,n=3Dno_dir100}  still
> in use (1) [unmount of tmpfs tmpfs]^M
>
> Let me know if you need further help to reproduce.
>

This issue was fixed by the fix that I replied with to patch 9.

Thanks,
Amir.

