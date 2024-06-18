Return-Path: <linux-fsdevel+bounces-21883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367E90D565
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192671F23AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84B15B131;
	Tue, 18 Jun 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAcNWk7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0315573F;
	Tue, 18 Jun 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720383; cv=none; b=Jq4sU0KoDPPJ9qZyohhP7sx15NxOpKbhTK5dw7DVlrQSrQDlwwzmSpOhKdCuIpeoe5UyOu/ElmIdJ0B6/kd9aSyNGPm4180Su/65S65QMs1BOKRBVFUNjncVE/Z2qmbWv9HDgsb4I8LZPuOr+Nc/DjuEgNmYoCjkb09qHTQ2Ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720383; c=relaxed/simple;
	bh=UqZBiwmvQMI5HGnnEhRCGYjgZawaMVa1pp26/ZQFIes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQwq2KfEB4Pkln57awJH92eaUcpkwByb7u9UvkGG5mvp2I2OnrsE36QtXdY/e9xYWJSiVsrsIssW4cj9vL52rZNIVkaK4roaAXiHG2rB3Q1R4H0CEuFwcXDWaAQGq3owr0EZpjsOchXpArAGM4kj//fzcFld5qitg5RXXtrxZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAcNWk7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99C9C4AF1C;
	Tue, 18 Jun 2024 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718720383;
	bh=UqZBiwmvQMI5HGnnEhRCGYjgZawaMVa1pp26/ZQFIes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAcNWk7eUuOFX2i8PJBf8Z5aTCdu8qAZllU0sTYORAnmCVGUGjFr7SwncOa8wRD2F
	 uL6buN28D7/bNMFeDKlFajhBNStOjpkcILIXDgTXLAT5aHSzQ3kPA7jA4D8vi2Mpwq
	 +BxohKMW770x5tyoBkRE/1q35/hluYKIf6cs9xJDGIJnCsTbYad9APhTlfKYIOEn7N
	 I4x+orNY2WSIcYqprbr2BbEL+H2I9U08otflJKJFJjKfl0OClBqoR8HfhqeqQ71nzF
	 9lxXJmqVGHPgByL4X4O287IAnQqS1VZZelUFK//GQPtDIMrOHJwOD3TQpYtwA/6Dfj
	 MCbe9NGZcUOFg==
Date: Tue, 18 Jun 2024 16:19:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neilb@suse.de>, Amir Goldstein <amir73il@gmail.com>, 
	James Clark <james.clark@arm.com>, ltp@lists.linux.it, linux-nfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
Message-ID: <20240618-wahr-drossel-19297ad2a361@brauner>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617093745.nhnc7e7efdldnjzl@quack3>

> AFAICT this will have a side-effect that now fsnotify_open() will be
> generated even for O_PATH open. It is true that fsnotify_close() is getting

Thanks! That change seemed sensible because a close() event is
generated.

But I don't agree that generating events for O_PATH fds doesn't make
sense on principle. But I don't care if you drop events for O_PATH now.

