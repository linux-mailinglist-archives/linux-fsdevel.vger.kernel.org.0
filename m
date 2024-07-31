Return-Path: <linux-fsdevel+bounces-24694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09094326F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075E21C219FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB801BBBD7;
	Wed, 31 Jul 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9AaZL7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4911B29A7;
	Wed, 31 Jul 2024 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437384; cv=none; b=oO92B2R40W36Kk8dlwNrE0Ti0IXv8R/78G9HAANs3XxzuOrLG4duUfmKFzjAXiuxPFo6M1YMcXBoGHIPhyesjUaCHvjFv+vrcSwCGRzJuu0O6yge0HI6jSA2Prbj5nIKT447EUp6LZyCIuNzqgIY5irC89tNBWcALi/Fj0fuYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437384; c=relaxed/simple;
	bh=jvSoiImoeatGIU02YOZvvTAmYJNHVJGu4eoWQlTdHbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly0qQRGrE7GM+Cuz7OhTGYwFq/v0OuqHhZBAVgRfY6UUYU3pTxyud1c1husRfNK3WOvh8BGoEHuMQ77Z/gqJoe1/UcbGZBASr60XrWvOu1iTf182MWEuVNS5sGNAxT9cWz6xAMx5PhVWY3aeTae8xaz+sBya+15ThavcSp5OEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9AaZL7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E6C116B1;
	Wed, 31 Jul 2024 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722437383;
	bh=jvSoiImoeatGIU02YOZvvTAmYJNHVJGu4eoWQlTdHbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9AaZL7o4wrpvlCBAdqYWXDCY+prUjziWUH+V00w0MpcCeyzg5Q6zg0PgAy7W2m+5
	 wmUJH+pvOtOYFqYb1rThpiV52b7e2ZGtJdYBTCwV3KnpRccdA+bjKuDCrFVYEGEswO
	 38q0mkUGmp5XEzVSYKui80dJhMnQqt90Sqrtsgz5HktbxqqyEX58Pyex0foORAqdwG
	 RFmq3saz99H2oSstopsEPCULF+2oQwqcSB0gdzN9A02XhydeXEwMmRVKpCCHdOG9PC
	 XGVOU3xcfV+bmDUuBv8pVOhVLGv72xUJtCN4QiLoxRRnFjrfo5ulpCzKLjnr/uA0Q0
	 AdLCExw9DpMcA==
Date: Wed, 31 Jul 2024 16:49:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, liamwisehart@meta.com, 
	lltang@meta.com, shankaran@meta.com
Subject: Re: [PATCH v2 bpf-next 0/2] Add bpf_get_dentry_xattr
Message-ID: <20240731-wovon-auskennen-72771dd67516@brauner>
References: <20240730230805.42205-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730230805.42205-1-song@kernel.org>

On Tue, Jul 30, 2024 at 04:08:03PM GMT, Song Liu wrote:
> Add a kfunc to read xattr from dentry. Also add selftest for the new
> kfunc.

Looks ok to me now,
Acked-by: Christian Brauner <brauner@kernel.org>

