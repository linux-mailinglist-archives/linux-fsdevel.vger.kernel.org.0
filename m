Return-Path: <linux-fsdevel+bounces-60708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDEB50351
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829D3541FAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4E35E4C4;
	Tue,  9 Sep 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl51pEoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8D35AAC3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436912; cv=none; b=DlsCAp797YhsTFYLNVvO4UPJ52vihfBJeHCvGvbSXGIf2PnOQZ+7oJtfY/pB2lO3FyiQSbvBQuEznT4JDQIpHdGUtXIzbpwAm7hHaPFvbyxwqvsiaPpBOF2D5kGEvg3cj50NicwAbzxBPdOjbicAojvHEz5YYJJhow/mRtGtGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436912; c=relaxed/simple;
	bh=1O7LZhi0OuhW8cM/Eeq8iDINCDkoxMyhrOQYOi3d8p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBbFWxxfoKDAY6zxP9v6/iFZwbG7uz6682ZFg3ocBmGxDUCxQL5woWE8ognPYdae+wJnBzBt7b8PPPG4mu0L+V6hfqZqL12YzNhYNZNKuVjNPJkMt4ni0NS+hzNanLaq+LJq1z+IlIXgnBrL6F4Dw/JjjG/FjEdyqeZvxF5Zacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl51pEoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6897EC4CEFD;
	Tue,  9 Sep 2025 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757436911;
	bh=1O7LZhi0OuhW8cM/Eeq8iDINCDkoxMyhrOQYOi3d8p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tl51pEocF/elcQPNIQXATZulkGu5rPzwiG4XUFJlsNatylB52NnVLViYDbK4cVZ+d
	 ROCqZHPH7hOFbk2fNnVnKHsmP7oZzZDsgk4mIsLc1TAVWhm/QWdFu8dTRdgVpdCSOz
	 4E0ERR9XFa/tNl+0XChrxDidavsAu0WsaDl0hzgD65F8jKQb6eQDxO+ydRq5jqWh+m
	 90JqNJ/b5s+tar73LQxSBdpc/b+IVRghRI9toRQjhzPGM7e2NXXTKWBTtLnvmHFUKJ
	 wcHH/Cv5DTkGy19ntF3Tqhsp9xMACWqH5v2QPaQ8bfIoCmiql33A7LLkgk+u4J8XTG
	 gbkFOynoXOAqg==
Date: Tue, 9 Sep 2025 06:55:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] writeback: Avoid softlockup when switching many
 inodes
Message-ID: <aMBb7utQjrdD62Z5@slm.duckdns.org>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-6-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909144400.2901-6-jack@suse.cz>

On Tue, Sep 09, 2025 at 04:44:03PM +0200, Jan Kara wrote:
> process_inode_switch_wbs_work() can be switching over 100 inodes to a
> different cgroup. Since switching an inode requires counting all dirty &
> under-writeback pages in the address space of each inode, this can take
> a significant amount of time. Add a possibility to reschedule after
> processing each inode to avoid softlockups.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

