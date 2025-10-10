Return-Path: <linux-fsdevel+bounces-63750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD965BCCC31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A6EC35548A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A762EFDA5;
	Fri, 10 Oct 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXanLDEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1928726D;
	Fri, 10 Oct 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095464; cv=none; b=gJyQNo1awqgZgn3Aw56KnE9Vuwea7N2kZjtIxJHaht3ejPehPkbiYQPJPD6YMRa7Gj33T9fXELBmLaIN//CthHWPlpVQFesbt00PzidGq8iDkIPtblKXQBU2U/F2bHg3pAI1rTCnQsLQ+8EOmjAUaw7+qgSVgTnGOnfRZxP95vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095464; c=relaxed/simple;
	bh=kg837NxmZOSgA9tET8qy6RDXHsUNQmBoZOaInlJgJl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSILol4mQtfFHJft8a7utKlFmPNPnVmPRR9dWH989uCfnogoQcthVAB4DWkveUagZfOykNTtrGYC9CApXJgGsqkWaPPzKQ7pcqsEokAdGbWbSIhcIJzZj6zva1xKP1PFUyGmYs/8Ic5bx9jEgetqyybwUPKeP+CxDg0qvDGDu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXanLDEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C172FC4CEF1;
	Fri, 10 Oct 2025 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760095462;
	bh=kg837NxmZOSgA9tET8qy6RDXHsUNQmBoZOaInlJgJl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXanLDELgBNBOxBd/ZBE2FazKcCnSLO7KPtVGHWFzwDJiWeBP52LlomQQllxp8Jxd
	 Thdu97QUlnMgILT1Ejffob/aP6rnCWH+WqjdrlwwcAR5aXnkF4yinOBQqNqFJrX6Uk
	 ET2PkRYJEtwxI4LFDpyZ+YTxfjKEsy7DT56RAZ1hq9mQT4QWxOsMXSA3BQukATjUeE
	 /sEOtCKXs37PP4RPLhoBz+0pX3WJWzVTHhaJQHDYnMJ0/hJRohqhrVo1ZmvWieZbHz
	 /oVFZ2bs9CyLzvg9w8A8r998vum/AI9ewU5s3KDUJPcpVLalCjWiee5uHpYzFpshzd
	 j0WxKFrASOVCA==
Date: Fri, 10 Oct 2025 13:24:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 00/14] hide ->i_state behind accessors
Message-ID: <20251010-wohnt-raufen-c1215ccf5351@brauner>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>

> More importantly though, this is generated against:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.19.inode
> 
> but that branch happens to be significantly lagging behind master,
> notably it does not include some writeback changes and bcachefs removal.
> Thus before generating the patchset I did a rebase on master.

That's fine I tend to rebase from time-to-time until -rc1 on is out
which is the final rebase.

