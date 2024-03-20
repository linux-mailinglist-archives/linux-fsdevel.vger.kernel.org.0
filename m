Return-Path: <linux-fsdevel+bounces-14876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F62880E2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 10:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAB7B22355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23F139AF2;
	Wed, 20 Mar 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kooBkHu0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65E38FB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925224; cv=none; b=h7e4TLsl3ZVBtNHBBLXOj72qa/9fJ0GBkB5JvFN+MpJvx5HFXlrY32fvpihuSK8K7ZjBLFrSZEjeTAk2gzYgF87mCpAO9Ml3jaZVbPxpDpjaUsEtSBeUoiOMdwjAR9nOXXalZGQoBz0VjuBYjktKNA/qaS/2AG0AaOIwj85Sn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925224; c=relaxed/simple;
	bh=KEOR6w46mCVENtC1ElezK/U9P17q0tL+PHAu3G130HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/zwWz+WR5kES/K74bxBNnpEHW+VA+m6dD/gx570pBJ2KRrFZNKUeE+AwJgw/H1NFMZtuiXN791FO0TxBFroL0zn5qqjRTgxNp1qmBYToj3dl5GkvR7kcWbFh9zWmlFR+E81wew2zmYMIUhqigcpQ8ET2pWShVViRwVmTI0ja6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kooBkHu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E010C433C7;
	Wed, 20 Mar 2024 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710925223;
	bh=KEOR6w46mCVENtC1ElezK/U9P17q0tL+PHAu3G130HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kooBkHu0nNr856n+QmMbU4ayBHZVborpuJNvpXRaitNLkRphWVzDXAbSUW3WEfpLI
	 IumielUmJEKb4zzKxb8Dw6aQy+7NppOA4ECQEW47IDcbSyUp7S9kbOC/YLUpn7Atju
	 KgUo8PKIIjn0RO+ySd46nv7ge6sGqhcXFqQOeJgvcjtv7GcuE5lMQwBxDCILBSdmu4
	 BaxSAqQ3QZm9+TniNM5MjpmuQvZ+aTwf7VOmeenQSr7+U2prJfocUVUdJLNRltoKGK
	 outUI7OEJ/emSppNkEpVwOj40HoyWFxxsiVjzK6Lzhu9C2lqRcATLJw9NxY1R++f5J
	 yAeY1NbzMsgSQ==
Date: Wed, 20 Mar 2024 10:00:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/10] fsnotify: move s_fsnotify_connectors into
 fsnotify_sb_info
Message-ID: <20240320-legitim-heirat-c09d3b991349@brauner>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <20240317184154.1200192-9-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240317184154.1200192-9-amir73il@gmail.com>

On Sun, Mar 17, 2024 at 08:41:52PM +0200, Amir Goldstein wrote:
> Move the s_fsnotify_connectors counter into the per-sb fsnotify state.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

