Return-Path: <linux-fsdevel+bounces-20009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A708CC573
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580FB1F23C39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E0770E4;
	Wed, 22 May 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+S8+GFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C11824BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398603; cv=none; b=kwskfeYFzXlDpH0dLFAph68zfGrYxmjo7Cam66FdGC0bGlm318gjvdD70BtQx6l6E0sMMZtQz6+rzgid1GWrK5fxc82Hgt1NyAfvfB5NWWZE6zlg8hkqzITxjpUZD5SodqtDAWL/jbmSyg1Yq0LyOwdd6yPWWWZvFLlPzyg6BU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398603; c=relaxed/simple;
	bh=GJIkDdZQNvEqojr6D5jUShRhjq6gyyKgwkANB5Wvd2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbyhTgFyxpU2fy7hTW4pHzG75ejrjrhiFde2nmiyB/4u45x1vplrSViLt8I+FanVib+iU9jJtzlmVIsBX2V2jqoV/NY/7O9U6Ysbyq7IuCrnH1p9PGWqEACwBojRs3yamTLzD5XRID7L6PPdorjDKVF3oYtdO/IddM4Ke2Lxln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+S8+GFz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716398600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UExHI2mLXO/DWBTe7HS7d2TOll/HsOeJi+GPvttKqw=;
	b=F+S8+GFz9iaJdOLE6PlcSfMTqNirLgePsIw+6bmwDBys85knMInMgycQUJm3GHdnMwnBqR
	faLllUWedbrs34WG5t1EgkGTqV4mK4+35tzuuOthBwakNvZpL7u/wmpi+SLUEMSM9iONSg
	DekkdC97ZiMbtqskV9/o6zadvTJkgDY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-MS6PigqWOpGsY3laWz671Q-1; Wed, 22 May 2024 13:23:19 -0400
X-MC-Unique: MS6PigqWOpGsY3laWz671Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41fc5c5cc95so63552775e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 10:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716398598; x=1717003398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UExHI2mLXO/DWBTe7HS7d2TOll/HsOeJi+GPvttKqw=;
        b=Sk1ZTbUtH7QR4gSuLC78oR2mNKM8qzZOEdPy+cv7a8+54pEfY9OpbbjQtIfHdAOM3F
         2chAuz4I/3U3bcoXm+2gz9Y3jlnbCecR1w81H/NRziOdjSID9e/FN11Qy5w1DemIn7u1
         kWD3WjikOhnRpjtWjBZ8XbHpRjM0WYs8XlLn/fbemxUabbwjFdN9Y7SdHa2FFyp0EAYn
         joH8XSUGZjIhym80qwDH15DPp4A5EKR11I1vvVPDPKxDOSQi2xz88pLbVYGr9fCm/FxJ
         f2V4rHWmafIqGUJQHlbY4djLTQV8AUN5SULGPGkPijWCCIcASoFk3Dvt+yTiVSW2QYsA
         gNdA==
X-Forwarded-Encrypted: i=1; AJvYcCWNG2irfIhKX8LPNeNJtcO1TJWlk8trpkG6VOO5kLu+E/+LWFxXeOjDEMvRzg8nr1d6On3UmGjTndvCfvtDh30TTcvEK0v7rDGhKGOUIA==
X-Gm-Message-State: AOJu0Ywy2uD7OGakVBo7Jyq//lUfM6qSks1CS9pL3/5GOTdeW4hj5BH+
	4Gw1xYLEtBPCxOwaNJO7dXNWcsIZ9WycjVTOsCYgLghU7a4qdsMRLpznXryatFvVyDwLL7NFusb
	YKBQAsDRI49n7ZiLcm3Ji5puoeKXxqtEopgRVGPiwev+iHsTTFrPKyB7DVRN/AA==
X-Received: by 2002:a05:600c:202:b0:41a:aa6:b59e with SMTP id 5b1f17b1804b1-420fd2db0d6mr24257625e9.5.1716398597824;
        Wed, 22 May 2024 10:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp2u/5LWgc3wiT4UyPXKCs3TkmMQxuWR+0ZI1kXDCl1wNiONPyKA/sGREBAF9BLgbYHhy7+A==
X-Received: by 2002:a05:600c:202:b0:41a:aa6:b59e with SMTP id 5b1f17b1804b1-420fd2db0d6mr24257345e9.5.1716398597150;
        Wed, 22 May 2024 10:23:17 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ef42b2sm613205e9.5.2024.05.22.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:23:16 -0700 (PDT)
Date: Wed, 22 May 2024 19:23:15 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <qrjb7dq2xc4zhzzevjy7vqacdonyqkoylkthp42rlwcfbvlhl3@zflo33tunkyq>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
 <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
 <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
 <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>
 <20240522162853.GW25518@frogsfrogsfrogs>
 <20240522163856.GA1789@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522163856.GA1789@sol.localdomain>

On 2024-05-22 09:38:56, Eric Biggers wrote:
> On Wed, May 22, 2024 at 09:28:53AM -0700, Darrick J. Wong wrote:
> > 
> > Do the other *at() syscalls prohibit dfd + path pointing to a different
> > filesystem?  It seems odd to have this restriction that the rest don't,
> > but perhaps documenting this in the ioctl_xfs_fsgetxattrat manpage is ok.
> 
> No, but they are arbitrary syscalls so they can do that.  ioctls traditionally
> operate on the specific filesystem of the fd.
> 
> It feels like these should be syscalls, not ioctls.

Won't it also be a bit weird to have FS_IOC_FS[S|G]ETXATTR as
ioctls for normal files and a syscall for special files? When both
are doing the same thing

> 
> - Eric
> 

-- 
- Andrey


