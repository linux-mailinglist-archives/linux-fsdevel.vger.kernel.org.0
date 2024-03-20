Return-Path: <linux-fsdevel+bounces-14863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E7880D07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A0C2850F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8769A3AC08;
	Wed, 20 Mar 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4z8VBTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A93A29C
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923343; cv=none; b=IT0BRHnilzy+xBUQVU/GuM+kIDVs6AOI5AbQAkpu5Pq6WBbkgVW5zOvqqDDGpprWPTqVCTipK5Jcluq8gVZJyFbbnUCRInS+HnL4Ce6vHpKnxmDUU56VHQFpNAW+d2wfkycCo7gv4re4kUcDmJ3xZ7jnar8V85FwURnHJbt/uJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923343; c=relaxed/simple;
	bh=UM0lbs7oI3+dIhHTVqlXQcJlLEArD4w1c5Acegk4Tqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc02Aa9QCm7H3Gh9ILdbvvUOkgVTcPAt7xg+DaqanbH2UUCsQfImZvOdXfr9ugaTvcC2yi1ByMPa6pxkzD8NIXHlsLxlwgziQFAPdzCKBhRAbxWakO89AIuqNDZJ0G1ES+LXEY7P2R940jP6lD8DvVI/wU3Dj5AWD58cJ7yopCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4z8VBTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A406C43390;
	Wed, 20 Mar 2024 08:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710923342;
	bh=UM0lbs7oI3+dIhHTVqlXQcJlLEArD4w1c5Acegk4Tqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4z8VBTJc4fiJZq0tO7Eou9g+7lMwmZ80ozPRpBWwKGYsxuoKR26nyA4FnTfvCJu7
	 48tIhvb2VhnzYwqrmVtgq5Px7QhPkIj1LbOxcPQ69zDc2aXovfOWHdZcC78ZlYWtz7
	 sgI2UeaDLYg1373W2ee64RaRrXBrqOOqGqSNUv5XN5lBuRd8z0pUXOGmfUue/hPiWF
	 V1ypl0P6N530RlM6IO4sVoK9ZjsahkKMGqH0BNXD72kSWmOHi7J80kk5ojwqqAL3o6
	 hA75uMe9TcXkZw2AVc3uviVDrHzSf4RonNR/dDY0miVsdtuUQO4lUyqHG9tzNCRS+i
	 coYhM2kpeQrWA==
Date: Wed, 20 Mar 2024 09:28:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] fsnotify: create helpers to get sb and connp from
 object
Message-ID: <20240320-versorgen-furios-aba1d9706de3@brauner>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <20240317184154.1200192-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240317184154.1200192-3-amir73il@gmail.com>

On Sun, Mar 17, 2024 at 08:41:46PM +0200, Amir Goldstein wrote:
> In preparation to passing an object pointer to add/remove/find mark
> helpers, create helpers to get sb and connp by object type.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.h | 14 ++++++++++++++
>  fs/notify/mark.c     | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index fde74eb333cc..87456ce40364 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -27,6 +27,20 @@ static inline struct super_block *fsnotify_conn_sb(
>  	return container_of(conn->obj, struct super_block, s_fsnotify_marks);
>  }
>  
> +static inline struct super_block *fsnotify_object_sb(void *obj, int obj_type)

If I read correctly, then in some places you use unsigned int obj_type
and here you use int obj_type. The best option would likely be to just
introduce an enum fsnotify_obj_type either in this series or in a
follow-up series.

