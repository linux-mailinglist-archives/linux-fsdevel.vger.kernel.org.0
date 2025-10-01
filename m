Return-Path: <linux-fsdevel+bounces-63133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE5BAEDD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 02:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA7B3AC1EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0191607A4;
	Wed,  1 Oct 2025 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5chLawu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3EA920
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759277894; cv=none; b=f68MZVOmP9QfCNRntPQnlISw9o2CbbSAG0xR4p3RaxoFz61M+7JJWOvOA7aZYfetsyHrpjUKWr1ZDC3zUZhUECFiezEt+9FfhcLo6mm1alJZX1oQSAjRHX37IhF/H0pc6j3GV7orwn7Q73ybn/T2COytLtHodP3QzMxxlpCfjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759277894; c=relaxed/simple;
	bh=ALkBQDD4i/q3/CdEcvDh6wND2DUTXg/EK4CgbQvQ7Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruJMISgGs/g/4NFysey7CAPKlUN1miuIs0SlcnZW/D9GRh5bVjArGXtIyFy1Sg1YYQ648NjxgbLJyVr1qEHYsYJr4adyOAn3/qZ3E2x5Oj1QX/s0kaC68TxSBWTRAaIUZBk8i959/z1tYg5chFsYmU5egxdcfvj9wnRmA0LT6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5chLawu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4df81016e59so37730821cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759277892; x=1759882692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALkBQDD4i/q3/CdEcvDh6wND2DUTXg/EK4CgbQvQ7Ps=;
        b=g5chLawuXsJ0OLjJLsClBF3TubcaPr5rVOhWPzvY007M0ovGzOHJfvWyBHlDDbOoyi
         rm4yH1faA8zLkF3h7I5ZIgLA46b8q/szCG2a8Bt3xdw8wWl8XFXxo1zQIVW2jsYZvBXx
         MnjemDpP9PlSIkdmTKh+p+LjoT94Pn/1pxbG6gZXMxxTbK8XKC5JH3SI8//zbfHaKnc0
         Oj5O4DJLpNCWnvTawymcC6g64qUPKUpSsMzGXQqeG/WtnUUnponIFsEswGMk5cp3Hufu
         XAFUWwZ3FzfbTtw5p1j6XuQ8xSijSMRo/sw453LqVM3xxUbRFTLC88ZMlG3tRkE4xJCU
         P+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759277892; x=1759882692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALkBQDD4i/q3/CdEcvDh6wND2DUTXg/EK4CgbQvQ7Ps=;
        b=C39RDL0Zk8f6tqtQSmnslu0JBxq7dsB9mvKudhGBM+XP/hHSdQM1v7l4jpG3YxD+HQ
         LmShll/zB7/4DwlBjgAmHWzaxK15r3IPGGnu3nl281joa3gmFo8BG9BbRtAq3A0qBvr1
         TrV29sfYZEGTCpxiTrH9Hd5jdWcT3FoVWXBc8jKeXSY6/DgJi3wftqjjTnUhcf2qqNxo
         l81JKUwgojhK/Ud2TyetEgvnrcPsThtmdb52XhpVS/sTAl4CVy7zBT9eyAPrKTkmgTZA
         sZWGtQIKNyjHA6kxgFFiZzZCwVP1bCNBDnjNnmnlgwxu8gWs5TM1XlC2fmlGGpXdKb+B
         a/wg==
X-Forwarded-Encrypted: i=1; AJvYcCUuE+wWihRazVSZFi0pNAPQzJrW4yrNnR6hMCUcdK5GwvaY0kmlgzFqc3hGNietnpN+Q3WWI1UQgVNWXD8k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VTBdk6aDBj3Z33Aeib8/N7bVM3HN/DdeGY7SFh6IzOLlgDV9
	jNGQgaUzDaOC+0a2cN7LWByWr0PC4eHz/3aHufCNlJutgSwO1hD2MahRV3SWOAZ5QdizdNt/LwG
	WJRp++eRx5iIVAU/qi87gBfXHnTn7C0k=
X-Gm-Gg: ASbGnctD3YKyGnCezB/Nk10kvLd2rZcRK502Mrgw8GCwoR0O6OTizDfyWBKQJa51Qox
	UrkIdbMEGCnvcUtHHJAA/xke5D+7O6rO2nG+3qK12MzTqWHsXvr0oGCreU9Ql2XJR1lM9AO+OeC
	QdZkxF45Jma8DESOVrhAmGrmrINXCu95IbmhMYdpsyHwK7xlMTfXDDa5YAsxtYR1Ntw/9yseaO8
	xKDS+q2vhCkCfjKb2GlHS5P6asmbQg2k/UIxHQCbg3gzy7PcoRU618zxgDrGfc=
X-Google-Smtp-Source: AGHT+IGJOYhhGFHF8JKlRXmVI8SNaXHdbegV8oRPnf/MxqDcEiowGOLnQZe5XvpwdDDRL7ta49IpkIi0dwm7Eu9uduo=
X-Received: by 2002:a05:622a:22a9:b0:4b7:9abe:e1e4 with SMTP id
 d75a77b69052e-4e41f7b1130mr19387201cf.82.1759277891903; Tue, 30 Sep 2025
 17:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com> <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
 <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com>
 <a517168d-840f-483b-b9a1-4b9c417df217@linux.alibaba.com> <CAJfpeguSW1mSjdDZg2AnTGmRqe7F9+WhCHd3Byt2J7v4vscrsA@mail.gmail.com>
 <CAJnrk1Zty=+n4JEeOAWywhtBNQ5cNzHVFzPVY=KSHhX5Qs_1Yw@mail.gmail.com> <CAJfpegta+q6vz0KWji62cvB2VPG6qscKERC7iH8ZR-_et3AAaQ@mail.gmail.com>
In-Reply-To: <CAJfpegta+q6vz0KWji62cvB2VPG6qscKERC7iH8ZR-_et3AAaQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 30 Sep 2025 17:18:00 -0700
X-Gm-Features: AS18NWCmL9T4dTB2zC2P7NcTpF5Cvu3NQu_oEB01A_kzpV8_GNtPT7k8LQLqHg0
Message-ID: <CAJnrk1ZjAj9dbQvJUari=dpKo-Gm8v+YN4=0rcLJj8Fp3crrAg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	osandov@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:55=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Tue, 30 Sept 2025 at 20:47, Joanne Koong <joannelkoong@gmail.com> wrot=
e:
>
> > Or am I missing something here? I'm not super familiar with the mmap
> > code but as far as I can tell from the logic in vm_mmap_pgoff() ->
> > do_mmap() -> __mmap_region(), it doesn't grab a refcount on the inode
> > or the file descriptor.
>
> mmap keeps a ref on the file (vma->vm_file), so only munmap() will
> trigger ->release().

Ah okay I see, I thought the .release callback is for when the last fd
for a file gets closed but clearly that's not how it works. Thanks for
clarifying that.

I'm confused too then how we can have a fuse inode with no refcount on
it but with one of its folios indefinitely locked. The paths where a
folio can be indefinitely locked afaict are from reads/readahead,
buffered writes, and notify retrieves. But each of those paths hold a
reference to the inode, so I'm confused how we end up in this
situation.

Thanks,
Joanne
>
> Thanks,
> Miklos

