Return-Path: <linux-fsdevel+bounces-43593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A0A5925D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC4B1886944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E55227E8C;
	Mon, 10 Mar 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsQNhNyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454128EA;
	Mon, 10 Mar 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605085; cv=none; b=YaG5a+u2AnsBmunalGkVV2n6Et9HippdtIcCdKX7sx/9iwQWb1GO0LLTUkChVogI7o7g42wUJolILG4ifeLzbc81JaIEhv2VosJRz2iULjz3aYMs/+F5UOXGjR6Kc7dClajhRaGcfz0EB+KZPm8MMxF44LQCpbM3EENtblb0fkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605085; c=relaxed/simple;
	bh=PcALL6rKv2YNRdk+iN9+OwtZnMRQ9F2gIOkzlA2Ao6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IutcKiZ8QBeRjdR2WjSHZCSYYvWRDLnmdt+6r19H3rUFoSY7dJWz5ei45GfVAMPruXJY/9HckhMJz8jacJrh9iE4zASU6pyGCm6ZXyXZLW/UiqAa+kzMR38oESIXOWo2oAqYSwat7UIVjtTAtDdZXL+IZDd2uvzVlz1g5EIJZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsQNhNyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CF7C4CEED;
	Mon, 10 Mar 2025 11:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605084;
	bh=PcALL6rKv2YNRdk+iN9+OwtZnMRQ9F2gIOkzlA2Ao6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsQNhNyqz3u967OZhTw2W4L2OHEPx0a+JxTIxyp26cigk9kcup0dXLqRf4KPS2Z0x
	 R5nhRW793XtaSYoPQwTeJPehoPmBeEmrvNu/AUYOKIMWYUoYrH9Sp+ABXwkaM5UFif
	 WcpRC01GLwDFlrZ4p2KeMcRECUmu4WoHV5Kuq9Vyfe7078QLe29oJ0VfyuRh/Ma4us
	 kLCnbwdbpUTsQsw9B+OHFpE6phnZMvzJ+h+26Q9/lD4gzlhB4Nta30Afc7yivuVEAH
	 Ct4Az3AkOXX4YXxpAmxii4IUG6QAeZwoGHzbCsQdHMh/w+04tWYJ/AY7k42wOBDtuG
	 gil99/171VexQ==
Date: Mon, 10 Mar 2025 12:11:18 +0100
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 11/12] xfs: Update atomic write max size
Message-ID: <egqflg5pygs4454uz2yjmoachsfwpl3jqlhfy3hp6feptnylcl@74aeqdedvira>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <2LEUjvzJ3RO3jyirsnti2pPKtOuVZZt-wKhzIi2mfCPwOESoN_SuN9GjHA4Iu_C4LRZQxiZ6dF__eT6u-p8CdQ==@protonmail.internalid>
 <20250303171120.2837067-12-john.g.garry@oracle.com>
 <bed7wptkueyxnjvaq4isizybxsagh7vb7nx7efcyamvtzbot5p@oqrij3ahq3vl>
 <QIPhZNej-x0SeCVuzuqhmRIPUPKvV7w_4DB3ehJ2dYmLS1kwYGIJi1F3F34dhPTCy6oBq_3O-4Kjxxt4cIiP9Q==@protonmail.internalid>
 <c2fdb9bb-e360-4ece-930d-bab4354f1abf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2fdb9bb-e360-4ece-930d-bab4354f1abf@oracle.com>

On Mon, Mar 10, 2025 at 10:54:23AM +0000, John Garry wrote:
> On 10/03/2025 10:06, Carlos Maiolino wrote:
> >> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> >> index fbed172d6770..bc96b8214173 100644
> >> --- a/fs/xfs/xfs_mount.h
> >> +++ b/fs/xfs/xfs_mount.h
> >> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
> >>   	bool			m_fail_unmount;
> >>   	bool			m_finobt_nores; /* no per-AG finobt resv. */
> >>   	bool			m_update_sb;	/* sb needs update in mount */
> >> +	xfs_extlen_t		awu_max;	/* data device max atomic write */
> > Could you please rename this to something else? All fields within xfs_mount
> > follows the same pattern m_<name>. Perhaps m_awu_max?
> 
> Fine, but I think I then need to deal with spilling multiple lines to
> accommodate a proper comment.
> 
> >
> > I was going to send a patch replacing it once I had this merged, but giving
> > Dave's new comments, and the conflicts with zoned devices, you'll need to send a
> > V5, so, please include this change if nobody else has any objections on keeping
> > the xfs_mount naming convention.
> 
> What branch do you want me to send this against?

I just pushed everything to for-next, so you can just rebase it against for-next

Notice this includes the iomap patches you sent in this series which Christian
picked up. So if you need to re-work something on the iomap patches, you'll
probably need to take this into account.

Cheers.
Carlos

> 
> Thanks,
> John
> 

