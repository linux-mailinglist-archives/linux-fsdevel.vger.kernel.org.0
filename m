Return-Path: <linux-fsdevel+bounces-35737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2C9D791D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 00:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F280B22547
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E74F186E59;
	Sun, 24 Nov 2024 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIlOjVH3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE951632F1;
	Sun, 24 Nov 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732490399; cv=none; b=ddwC8No+9TQtQ/k/EIx/Hxvgiiq0rEV1hlxifIkRe0moAvKJT36/p9vbD00m5Z3bRDfxca1yw7kGB+0vJvwmGw2LbCMN/fuh75M/OtfE75cbA7DrHQ9bT0lmdOa1eLl4mzC+jNi6trrim0FfD7Ko0JK2C9CKs6LMMJ8+ZL893V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732490399; c=relaxed/simple;
	bh=FDgkr+nVJEe9nFNlOFSS2v5pgxqgjhmXjfSkEDzaPw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1B+qJflLhKWNIjq3xBP8//Yh4kqZ9lyN66zLyV5f9Z3wMz+Fu8treHIBqe5MRjnYByU7rE0zL3vKa4N0Es2M9cJx0+t7Aj64ywpA2Opwk6IjwZl/ATNtNVZK7IASuD7vdQaJ8VKe/SwtIZt4N0pyj+ZkUCvbX9W/0nUst92ugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIlOjVH3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so5892837a12.0;
        Sun, 24 Nov 2024 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732490396; x=1733095196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZSeyrsrMwj7Vz8/1lrt+/EiUgYqd95oAQ+Ko/mi8sY=;
        b=GIlOjVH3ddeLL/C61943thsz/E9zo6e4r8gCvKbys9oBVakrfzUd+IPCsKYoLFe/4t
         mvyuruQ/FzATPgj2wq4yHeyMTJtTR3UlYhr31KdCosK+TS69Nf5Y/X193jnezFH8+hxE
         8TJi5kvhDpyzIVnc1Tc7Sfa8dje52boJsI9pomCS07uO5PcWMtFSibLtBgVNc6NMNLBx
         KRQZbqkg+3LtaTMsasH1GtcXzIkzN9dUvkE5TdlYH5v6Hi6a9bEVdiNFtsL61OGRVxp5
         7dgVWg1voD8UobO20QfbNuMoXoE5GD9f7tk9XhdLvlYKOTispoQD5Z2z3O2O+QwKvDQe
         OoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732490396; x=1733095196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZSeyrsrMwj7Vz8/1lrt+/EiUgYqd95oAQ+Ko/mi8sY=;
        b=eriC+6Tul4B4Ut8DHy72pSIyI34DgBic9Og2zSV6n75DH8TXoc20L2qrcBeHnt7T6m
         L/2OeUKcQubS8qJhwr3Cb0kZmpgF5rWdDrRXxDTs9DNRWkeLnEI8VkDx1MlWDEhQI72q
         1gB01/ofjuDa+it5td0OWgYGNi/LFZbClXjx5m5RbMPHJGsnkWuP97m7zf6cqyE9Vyzr
         awoRjI9JY21cusrRxI3jG17TcMSyh7cHiN4u5fETKvsWvD9RRzr6aWD5BgEzIXdhi3cn
         2RAOYoK0rrPPmg0Obgpylcuy1IsKhJN8NU05eal1SB4TjByuSRwE/obIAe/belJlImE+
         wnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqbQJN79inXxtCoPIwa/QGf8My5QcyF0U/cfmgUJx5/VldzHDn0V7lKaWVV0WejlqX5rDDeNzsKrnm2hnY@vger.kernel.org, AJvYcCXtM+hAbXrqhCPai+GxhHLgujpsMCrQtV7n6e3dKAymujMRlnSYA6dy/U4ESDsUuuzQ3EEoRyw9cEA1RMqB@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQjoCupt74yDcOytOiPauniRAAo9tVEOXGAy+56nk7CYhTs/J
	9dTVPHnV9WqerQt10aSiBIiHrdrt95XOyRUQ5/kWQWsTMEFXlqSBapAZiWHkoE+zA/S/WYkm+vf
	YQJER6r/6yjgiwyCejUINAL3s+kQ=
X-Gm-Gg: ASbGncuU7alDf/HwCHXSKssnY0fMxt3Oi4ezz0/O+mmxgziLlBDXzX3y00ZuIVLDDYI
	wtUyYo6dNQoRJPAwYLiRBZzv7JMV5bBA=
X-Google-Smtp-Source: AGHT+IHhb8E2WJzS+2twhTTngIH12k08ICL23i+O8L3vzpj6+6Ge5pecHFKe+tpVFMXLsJC0qc1HMdxwCpVgWHvHmjE=
X-Received: by 2002:a05:6402:1ec9:b0:5cf:d2ab:6bf3 with SMTP id
 4fb4d7f45d1cf-5d01d367034mr10756871a12.0.1732490396232; Sun, 24 Nov 2024
 15:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <CAGudoHEqDaY3=KuV9CuPja8UgVBhiZVZ7ej5r1yoSxRZaMnknA@mail.gmail.com>
In-Reply-To: <CAGudoHEqDaY3=KuV9CuPja8UgVBhiZVZ7ej5r1yoSxRZaMnknA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 25 Nov 2024 00:19:44 +0100
Message-ID: <CAGudoHGyBQMtfgpq3EzaZi+zWBOoTADVro+Gb27DRHFF1iijVA@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 12:05=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> Looks like this is a recurring topic?
>
> Until the day comes when someone has way too much time on their hands
> and patches it up (even that may encounter resistance though), I do
> think it would make sense to nicely write it down somewhere so for
> easy reference -- maybe as a comment above getattr and note around
> other places like the timespec helpers to read that.
>

I'll add personally I was concerned with uid:gid pairs vs chown --
after all you can read an incorrect pair after getting unlucky enough.
Again one has to really try to run into it though.

So how about something like this:
diff --git a/fs/stat.c b/fs/stat.c
index 0870e969a8a0..302586d6afae 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -78,6 +78,11 @@ EXPORT_SYMBOL(fill_mg_cmtime);
  * take care to map the inode according to @idmap before filling in the
  * uid and gid filds. On non-idmapped mounts or if permission checking is =
to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
+ *
+ * DONTFIXME: no effort is put into ensuring a consistent snapshot of the
+ * metadata read below. For example a call racing against parallel setattr=
()
+ * can end up with a mixture of old and new attributes. This is not consid=
ered
+ * enough to warrant fixing.
  */
 void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
                      struct inode *inode, struct kstat *stat)

not an actual patch submission, any party is free to take the comment
and tweak in whatever capacity without credit.

What I am after here is preventing more people from spotting the
problem and thinking it is new.

--=20
Mateusz Guzik <mjguzik gmail.com>

