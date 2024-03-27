Return-Path: <linux-fsdevel+bounces-15389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 146ED88DAF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4538B1C25952
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F347A7D;
	Wed, 27 Mar 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYt2jmWd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E928DC8
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533920; cv=none; b=Cq46j3lpHcLp4GjuxMGakTyPNHh1e4NmW74+gn+wCAiC++KKpvwlHCFIJnfaiYG9ztu9OYZ4LUaBJySIgzzkrQKDp40bdkVCWSeqLvd7B1ytxGmQAyqpYlxgKeiz9fwMn2Ie9RisDF7ZNrjoFMEEWZFTyai+G62AMkUVx6zzM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533920; c=relaxed/simple;
	bh=7FfoVz4TyEGCuUBk5GbVWpV4zA0V5bwDX+w/IATyuhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3rUCHxG3E0YzJiLjWFNCw6FQdfuYrXSugddIYK3fdTW/7EY9uFuaJMYXVszWBP3AmPdj9naxahD2UJ5rBi/wwY5+Iztk/NTJdV2+5epZcdzTcyCCZVBCW26aosY1F0pctdkiWVKD/z+SaBITtcF4JfD/4yZKjyDJaOqGc9v148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYt2jmWd; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-696719f8dfcso29752416d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711533918; x=1712138718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU1fgsC+f92ydKdPUBgVrgtIzgqRYlgOSF8lmCAR6dw=;
        b=QYt2jmWduMhEsVu7kUXPWIUtAUnMj6sndBtLTblMORcTVcHhSOSfWtdHb2n1WVmNKx
         Tlz2Tdj8KZaiupxiM3PDTgT8lE+S5dPG1+GnH1CT6yHmY0zNpkQhnCokYpL6URg2t4I4
         w8Y1uTOPuqdh3hgfPqwOwKFFcDi/Urqo9hun1hdPBTgJIhZisdf5bmZZnuPy6QXf77HI
         /sZykECk6iYRzuSCN8aEHpH6OXlL7vEWo6fR7q0IxkpVNGHkthagEKY6vbEpNUa03kuy
         EW30lvtkeBmUjyTe0bb7bbBhziaIHJufqV01WSmEckQUiAvZvBV1RIwB3k4q/tswdg3m
         Eayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533918; x=1712138718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sU1fgsC+f92ydKdPUBgVrgtIzgqRYlgOSF8lmCAR6dw=;
        b=qfQ60grzm1NlM6uJsz1C5tFkIegxZyHHP+Wq8IN1f7ESbNxZTn8VCcpdX7sKZKr1Qq
         Ul+tzxMzfN72WMT/gaquOOzpLOs4AzMHTisJ62pjgMkUlt722V5q8Xp1OcH9rMwO4oUT
         c+J8sBlmPxNo+OKnDIBiZ1Ansdp7ClFt7TLi3XyeGPefAehO9bhoLAVsK2Ca+qUTWC3R
         kgOnUr1c6zolny6cfeYX9gy1nkhYCvvTQfy81k4tZD487XanR5T+cCRBpucNwjfWIX8K
         CuocPNSA82Utl+svSohFfxpsB1RgfKOAVV9yCGK9Gifq7bToJOTlVTNF3HNyRv2VGJpt
         Vr6A==
X-Forwarded-Encrypted: i=1; AJvYcCW0d/W4z/mHs3pKuK52NLMeMm/s5KrkAxs3ZXJ3eAqkOHd9acxHtkluVIe5F7CnymUysFD9lIO/tFv2LF8lHOYR7B1IBxF6mg8/DKH6Cg==
X-Gm-Message-State: AOJu0YxFXCThnt/jURQnOYVLbqlp7CzGuJe12sBExtaJRDnERZtf9pFc
	/SkNPsd7wGjWNPbm4BnpsnWmnGql0Jqr1r4QNPwfFzQMuDluYBQSaCCbw0vgdTasf3ytp2xjZH6
	igpF8nb28KsikzhXumvw+4h831cHsRN4X
X-Google-Smtp-Source: AGHT+IEEIN21ktOs0x0+fH1aMSO6FoqEu/BRMGtZ6rjX3h9fi5zhHHX/s3cj2Z5gv3WwGDIsdgReUAIKfqcYg06QP8Y=
X-Received: by 2002:ad4:5966:0:b0:696:20c3:35bd with SMTP id
 eq6-20020ad45966000000b0069620c335bdmr813921qvb.47.1711533918010; Wed, 27 Mar
 2024 03:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317184154.1200192-1-amir73il@gmail.com> <20240317184154.1200192-2-amir73il@gmail.com>
 <20240327100122.odg6bc4lgsrryt6w@quack3>
In-Reply-To: <20240327100122.odg6bc4lgsrryt6w@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Mar 2024 12:05:06 +0200
Message-ID: <CAOQ4uxie5D8hLX=wPSv7rwsk8nShA5i8AJmBvztQGBDvaiiO6w@mail.gmail.com>
Subject: Re: [PATCH 01/10] fsnotify: rename fsnotify_{get,put}_sb_connectors()
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 12:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 17-03-24 20:41:45, Amir Goldstein wrote:
> > Instead of counting the number of connectors in an sb, we would like
> > to count the number of watched objects per priority group.
> >
> > As a start, create an accessor fsnotify_sb_watched_objects() to
> > s_fsnotify_connectors and rename the fsnotify_{get,put}_sb_connectors()
> > helpers to fsnotify_{get,put}_sb_watchers() to better describes the
> > counter.
> >
> > Increment the counter at the end of fsnotify_attach_connector_to_object=
()
> > if connector was attached instead of decrementing it on race to connect=
.
> >
> > This is fine, because fsnotify_delete_sb() cannot be running in paralle=
l
> > to fsnotify_attach_connector_to_object() which requires a reference to
> > a filesystem object.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ...
> > +static void fsnotify_put_inode_ref(struct inode *inode)
> > +{
> > +     iput(inode);
> > +     fsnotify_put_sb_watched_objects(inode->i_sb);
> > +}
>
> This is a UAF issue. Will fix on commit. Otherwise the patch looks good.

oops. Good catch!
Thanks,
Amir.

