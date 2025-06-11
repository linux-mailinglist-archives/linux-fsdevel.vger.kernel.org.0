Return-Path: <linux-fsdevel+bounces-51293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EECAD532E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4321E3B2CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E026AA91;
	Wed, 11 Jun 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HStB+rZn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D1256C81
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639583; cv=none; b=QC/UaZR5DekIWL6J7fFn/jpjs1mxujJFtl/6v8SFcXAdaF8J1/kl7nywnI9YTkJBjLnncHe/H7fd2i1gFf68wFwhdbOeTN/1O6hTe448Eo4HW4Fqi88XXc6iE0RW+O1JgKaDoxgaiHqIwmBXQsjq86GQ5E21nRajkUW5CMHAW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639583; c=relaxed/simple;
	bh=o9yOHHJTPazeY9O2uNTNXSzDQG9OhdNVEF5Un4QsE8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY631ASlKrEyeIcxbNr/QgYhXTEuGyLkzsl6iviXE4pwoJ/7S4Sb5Lr7PcDQcu7bicnbqmwMUE+EWWy0O+ReYcVLlVo/eOoh8EvnYV6DfczTSGH1LSGlnzboU997PyQgUDyCtYIcnKjI/0jEAGicRhrKSk4cxBdpibd59Wxpj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HStB+rZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C20FC4CEEE;
	Wed, 11 Jun 2025 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639582;
	bh=o9yOHHJTPazeY9O2uNTNXSzDQG9OhdNVEF5Un4QsE8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HStB+rZn5ORQTDTUeagDJizjiZnrh4qoI40jXcsy3Zl9sxBh3o5btLFjhCm8r6lMK
	 hXfDx7dD8gRFlBPhQPV4ISIXilNvE00l6KerC0LSKHgPCrrW4swL0A1UNlbCYnXr6w
	 xzVvxw6JYioz5ZnJzussVtSN/6lBq0uwMgbPx0OkqJnov5B2gqN938slZbElfDf7Ja
	 e+E9+J2Q1S3TthGAJcEvQv5mZ6AcEgl4V2UblINMQJpZjIkZ6sCTLUiGOCbS+FqqOt
	 b6pXsLSBMhfW47GOxpzogV4R2EeUrZ9bduNogO2okV/QrnXwURlbLibCuV9eTEdXgn
	 5Y9lPVKU/lcXA==
Date: Wed, 11 Jun 2025 12:59:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 14/26] do_move_mount(): take dropping the old mountpoint
 into attach_recursive_mnt()
Message-ID: <20250611-behindern-umorganisieren-df64974a15fa@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-14-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:36AM +0100, Al Viro wrote:
> ... and fold it with unhash_mnt() there - there's no need to retain a reference
> to old_mp beyond that point, since by then all mountpoints we were going to add
> are either explicitly pinned by get_mountpoint() or have stuff already added
> to them.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

