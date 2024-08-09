Return-Path: <linux-fsdevel+bounces-25512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1594CFA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 13:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E658C28304E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 11:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15444193091;
	Fri,  9 Aug 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaY8gF0o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52A1917CF;
	Fri,  9 Aug 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204677; cv=none; b=jEfGI/8uKo1noSZ00UtAQFt19fdk/eAumpCOixlHFdKTulO7z0gKvAGa0SeDuxiQo4k89AvlPcNrE2eXv5Wt6D5qdbm5AN9rW179Xd0+ENRXyCHvvjbShJlku1yWdg1CuKqu2v/m1EHprfOHGt55kXDLk4C696wwseK22UopU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204677; c=relaxed/simple;
	bh=hiChtdwaEK426MBY+HvsbEkkE8p78ZXDC7QMlemZRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roxJA0ezXSv82Pkwyr/KmdYh75w5XMnd94QuBOrDtHwqLX70CdGQzrCjc1dmiz6Jl618NOFJ/v3l7U9cGkI1sDj6U2nENZOnacVWVX1YZ9UT+u9WrfLCsB9V1RoWEjlRRciHQcf76iaY/kxuJcbnVi/2lFqfNAlvaNzaQjV6S/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaY8gF0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E875AC32782;
	Fri,  9 Aug 2024 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204677;
	bh=hiChtdwaEK426MBY+HvsbEkkE8p78ZXDC7QMlemZRdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaY8gF0oWrt9/zl0rlTfs11yL3rAFOAflzqPfncNMKzlqvK26hkzQl+dvEEDN6llq
	 xffm6UwSDb1ChJ9GbUnSMCCNt7IGriQpAGi8q0r+dvE5BT0ETs/+5HGMaPucaJBjzs
	 k65ELQrXK2MQ7NCtoRhHxTwCg+EpRs+sxvA56mRxOAhjlyPTnrEuKO61NTH6QHRPFg
	 +++JCjtVEQShRzKxy3ckHrj0i5LkVDvDfBJMjidxMd7pWWAPqsaqdQmfIbg6cGEZcl
	 wij7QSaxmQNsdfOune8aVstr0HeOL/l0zEztIQamKOMC1bzKRJIFNMofRQNeup5uB8
	 cnFHbDZgpJYkg==
Date: Fri, 9 Aug 2024 13:57:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 05/16] fanotify: introduce FAN_PRE_MODIFY permission
 event
Message-ID: <20240809-zettel-zeitdokument-ceb3f319b8d1@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <fc0035bf78ca47e813f1fb603163af0225c491c7.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc0035bf78ca47e813f1fb603163af0225c491c7.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:07PM GMT, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Generate FAN_PRE_MODIFY permission event from fsnotify_file_perm()
> pre-write hook to notify fanotify listeners on an intent to make
> modification to a file.
> 
> Like FAN_PRE_ACCESS, it is only allowed with FAN_CLASS_PRE_CONTENT
> and unlike FAN_MODIFY, it is only allowed on regular files.
> 
> Like FAN_PRE_ACCESS, it is generated without sb_start_write() held,
> so it is safe to perform filesystem modifications in the context of
> event handler.
> 
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill the content of files on first write access.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

