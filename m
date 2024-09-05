Return-Path: <linux-fsdevel+bounces-28695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F9D96D191
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890D62870EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63878198851;
	Thu,  5 Sep 2024 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc0xccF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D50190075;
	Thu,  5 Sep 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523783; cv=none; b=JI4Y2DqvikaMhzzSTBBVMUHkcnSLXwRcL9nZZDnx5YzbdBozVUBhmoj0wvq5RPFLBW2eFkMNF3f6tBQCy5h58t4Mv7eYZyJnsPXgNv7yKWlX6fW6P3du27uJoh0e9nnltOBSJ+2ARa9YrdxH1hAMydHHx9lJ46HW6MxVV5g/xsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523783; c=relaxed/simple;
	bh=B7gJDTYbHMPnZJp4iYwXNdh2MTFMa18o7TILYBGASOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRyc+hCdx/ASQpFtIO41A8Fel2dgZuybsz1zT7dfgycP8CD7Czh0Jj3olPF+49LqMTXM6qkCeurpDze7xYoOx40H0AcvQf8+7NMhNE5aTe6sRDx7oWxUW9+y8NWa93twuttiYQk8z27I71+uLqbfu3NTyQPyxhgBYHlte/cos4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc0xccF2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1d22ecf2a6so598540276.1;
        Thu, 05 Sep 2024 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725523781; x=1726128581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gKqRHMWV7haALLKImll/o4tA/O/QxYb1m9nYiFRngA=;
        b=Xc0xccF25srL4W9YRNZB7811mH7ErDKeQY8PWyRzQE3hJ/WtFRyFiUAjo4Gubx+C8/
         ZlgndTORQ6ZjJP0ZgcDLa+OaiScsdTp5pt3xWIKeshtjit1O0E/IipgLIRUvNj/gUFwE
         06q6InmpfTxq/ZvPTMRT1QLxdDPMQ8yuSm/ypek95ZpGfXXgesPfdFSZEwN4qITfS3WD
         lFoJxZ9jIjt09kXyj7Q6Cs86TZwjCtn/wqFkuHTKezdaW9zM3HGGzC+HEHsJmSDPnd59
         BDpTdsHoukNRUhXwyFvCjVpzOMI7GAts11SCEyr/QpKE5lNXcm605kNKl4DhvbhUD5Pn
         q6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523781; x=1726128581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gKqRHMWV7haALLKImll/o4tA/O/QxYb1m9nYiFRngA=;
        b=JUSgR4qaYX5Ko/D2Yco+eMNKJ5dva7JH77bIwMjFlaPfo6iUCW88g/fVS8raRWSrid
         OeCElNwVdO6APBQfmTPgxQJTiqzmpHo3sVRPd+XwoIqHutnNCazMv0hEDj4IxAcbnfzJ
         BdDSraO8ZDMnTFfHBCb7OVi71k6YWUtr6Q9EGxDDzW3kJrNnyNFV0M+hHTSnavK5YJjh
         LZ6JCMmRn7RXlBw9/DTsHRfZkk7WQS7QHPxo4oVEw2VmRLyWASRv5Wn1tH4YXBymDJKk
         vaZUDj93NWkbaN/ALhbmbi/4PaIE63x3sQeSW+3aUXjQpxGHAa7Hxr9OG9sFEgJjT1sc
         Zs9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/MgZx3xrREee9oiSLuPWopo6ajEfhdQacQReD5QbxFHpUJUgv41RGeG6mbWWxlFyLn9ssZ948vdKK@vger.kernel.org, AJvYcCVAJ5ZVHlQNrax0mvr5q9wqglaKqzPaGHcOx7Pd0CZAzvf+oVTbLKWeeHFesrSTknVAT5WfLyMT0tDaEuMi/Q==@vger.kernel.org, AJvYcCVdCGepX6t+I8ZRLv63tWbF1xqfHiM7UaGO2K6+ca4l4h3XU8OfqUA4TV+tLWqrrzxpUTMojEe42S/yTs8CDA==@vger.kernel.org, AJvYcCWAZV/otvvR/Eo6qaKVVa8FRtmf172JhjUrzWB9dQIkUpC7tV9e+U05GKIn6EZmhygmWYmuMDExcKh3WPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0wfsbKtfGpuBEMzkWFppberKQ9drEU966KQcq8xXFDizaBYbO
	p7elFj+hISTPECVX09OvnNYJka4OFiYVkjLN3w3jAFqe8OditC2IGuwONb0bcqpUUi2js86n50C
	FcKapSrIHoLKR0l583iYE4jZqdh0=
X-Google-Smtp-Source: AGHT+IGjot5/qbygJ+MNRdyXqZUydHLOkiRglL9J68mmCxL7wLI/K7uUBjewLET2EHzSBNdnvO2AOLvdryFD+KIYNIU=
X-Received: by 2002:a05:6902:c06:b0:e11:7c82:ba5c with SMTP id
 3f1490d57ef6-e1a7a003c28mr24919089276.13.1725523781193; Thu, 05 Sep 2024
 01:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <288ff84b68a6b79a0526b6d53df2df5d184b5232.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <288ff84b68a6b79a0526b6d53df2df5d184b5232.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:09:29 +0200
Message-ID: <CAOQ4uxgD9jhJFAaD=AtU8vX9jrPzEV7tZOH0hFPJ-=HWXNqJSA@mail.gmail.com>
Subject: Re: [PATCH v5 11/18] fanotify: add a helper to check for pre content events
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> We want to emit events during page fault, and calling into fanotify
> could be expensive, so add a helper to allow us to skip calling into
> fanotify from page fault.  This will also be used to disable readahead
> for content watched files which will be handled in a subsequent patch.
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/notify/fsnotify.c             | 15 +++++++++++++++
>  include/linux/fsnotify_backend.h | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 1ca4a8da7f29..30badf8ba36c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -201,6 +201,21 @@ static inline bool fsnotify_object_watched(struct in=
ode *inode, __u32 mnt_mask,
>         return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
>  }
>
> +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> +bool fsnotify_file_has_pre_content_watches(struct file *file)
> +{
> +       struct inode *inode =3D file_inode(file);
> +       __u32 mnt_mask =3D real_mount(file->f_path.mnt)->mnt_fsnotify_mas=
k;
> +
> +       if (!(inode->i_sb->s_type->fs_flags & FS_ALLOW_HSM))
> +               return false;
> +
> +       return fsnotify_object_watched(inode, mnt_mask,
> +                                      FSNOTIFY_PRE_CONTENT_EVENTS);
> +}
> +#endif
> +
> +
>  /*
>   * Notify this dentry's parent about a child's events with child name in=
fo
>   * if parent is watching or if inode/sb/mount are interested in events w=
ith
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 276320846bfd..b495a0676dd3 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fsnoti=
fy_event *event)
>         INIT_LIST_HEAD(&event->list);
>  }
>
> +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> +bool fsnotify_file_has_pre_content_watches(struct file *file);
> +#else
> +static inline bool fsnotify_file_has_pre_content_watches(struct file *fi=
le)
> +{
> +       return false;
> +}
> +#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
> +
>  #else
>
>  static inline int fsnotify(__u32 mask, const void *data, int data_type,
> @@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
>  static inline void fsnotify_unmount_inodes(struct super_block *sb)
>  {}
>
> +static inline bool fsnotify_file_has_pre_content_watches(struct file *fi=
le)
> +{
> +       return false;
> +}
> +
>  #endif /* CONFIG_FSNOTIFY */
>
>  #endif /* __KERNEL __ */
> --
> 2.43.0
>

