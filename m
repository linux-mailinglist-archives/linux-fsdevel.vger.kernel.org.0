Return-Path: <linux-fsdevel+bounces-9603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815298433E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BCE1F280E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A39F9F0;
	Wed, 31 Jan 2024 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="D45KeAKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021F107A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668083; cv=none; b=hOY9lfLxHGtO01CL8dxVVAk4cEV0Dsx1SuHcbgDy3HAg5Oa2y7H0KRiDWmIPcVe61Z8OK2N4DY37vFTwRTfK/wbc0LMSRYUGxJ7c6daSqZMZdvCb30pWd9LhdjHaYSAl4/iuKvBUxj9625NUrAZy8RwqDDemCbq5KQtznWEvpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668083; c=relaxed/simple;
	bh=vL9ewJGQjbVzXzeBAWLNtgJlQ6U/GTAb08cdclhSXDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC5aPsB6dGoLmiSjBSRUVQAlttAuUg7YoG3QQklcsvRpNImUEQicKaF/N1tRVIFi19vEqa2geE2jwCeUzWi8giCaZjqk70m7dy8j5tsv1mBGlvkMkBAuE4B/YsJfEb8RB9l5TTffRqS/wvY1aF8Yu+/ZxGMOl0JwDw2hua8TVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=D45KeAKf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6de070a4cadso2119525b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 18:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706668082; x=1707272882; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rFuCfrepBWXS1XxHQhjTqPjsgtcav0dkeDXr+bSzRE=;
        b=D45KeAKfrJ98hS6d6uV3k+WVmM4ZVpQNftMQ8UcepF49jvwH1RWcNkrkF70O4dYahv
         tiHKD1xXz15tDg/a3/hFJHqZg6fupSdF77ozGdAgg7jyw+4CnnaIwAwhnoKFcJD5lV8s
         9WYG8Z19Df/P+wgLRJ9f7W9xn5w9GX8A3/UvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706668082; x=1707272882;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rFuCfrepBWXS1XxHQhjTqPjsgtcav0dkeDXr+bSzRE=;
        b=Qa8ZnhLjkS4cS/WqV0YC9q7O59lTqmfzQ+taq+pwXLNpGtdDwJxO/dVw9/Mv8lxrla
         fEwO7102Uqa+Aegj6EkL6Mc/JkDIXIw3zee6qNotJmJ4ChSOXN+x4+HVp5hfQXQCvjJd
         Qb2bzQ1YQ4gz4Lh4zDS497LRtBwZErjL9RS4B/neYgiPkRUyWofuHdz+RefnBpPysH4P
         lLXS2LIiO3uXdoQWwB4nYLal7reOWsln1M3vPkOqRq9WXRUOqqPQIrkeVQ3VfK7ZXqHQ
         gNYtRbvKqPzX8+zpVMMl68vNHgQw8z7tAM6CyDDvgl7/6ano6ng6zlMbQ7Ai6doARJSd
         EMzw==
X-Gm-Message-State: AOJu0YwD7WngK6DaqCPUE8ckN5+GjYuTYUYBV2kY2n5j6yC+DX5IhuEl
	ykF4SJKxm9J3OVyHkD+8VobLJ4onGrYm7kSWwUzu6+BUoI7dEFDhXK9l7HcRbB4=
X-Google-Smtp-Source: AGHT+IGjQbidItS+7RU7cPhy+bkQeiwZ/jpP5J+ABb5ADzdlxfdt0avRjFcD6UpscTVrmQlDW7WNQA==
X-Received: by 2002:a05:6a21:9206:b0:19c:7e70:d32d with SMTP id tl6-20020a056a21920600b0019c7e70d32dmr376162pzb.0.1706668081759;
        Tue, 30 Jan 2024 18:28:01 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006dde3053cdasm8574075pfi.133.2024.01.30.18.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2024 18:28:01 -0800 (PST)
Date: Tue, 30 Jan 2024 18:27:57 -0800
From: Joe Damato <jdamato@fastly.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	David.Laight@aculab.com, arnd@arndb.de,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maik Broemme <mbroemme@libmpq.org>,
	Steve French <stfrench@microsoft.com>,
	Julien Panis <jpanis@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240131022756.GA4837@fastly.com>
References: <20240131014738.469858-1-jdamato@fastly.com>
 <20240131014738.469858-4-jdamato@fastly.com>
 <2024013001-prison-strum-899d@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024013001-prison-strum-899d@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Tue, Jan 30, 2024 at 06:08:36PM -0800, Greg Kroah-Hartman wrote:
> On Wed, Jan 31, 2024 at 01:47:33AM +0000, Joe Damato wrote:
> > +struct epoll_params {
> > +	__aligned_u64 busy_poll_usecs;
> > +	__u16 busy_poll_budget;
> > +
> > +	/* pad the struct to a multiple of 64bits for alignment on all arches */
> > +	__u8 __pad[6];
> 
> You HAVE to check this padding to be sure it is all 0, otherwise it can
> never be used in the future for anything.

Is there some preferred mechanism for this in the kernel that I should be
using or is this as simple as adding a for loop to check each u8 == 0 ?

Thanks.

