Return-Path: <linux-fsdevel+bounces-17522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7B8AE9E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA351C21E4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687E513B5B0;
	Tue, 23 Apr 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GM7iSm54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9A7F499;
	Tue, 23 Apr 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884161; cv=none; b=alRdE7Aq0j+CX42zQkwz68WatWsP6YhlL8zcaguekuJU0hKff+JXQeFXbzG2LxpKMOkry7iheNkHNLzkaIdIdE9KnbBc13fELMB6SSwgXmSEAMDU8e6xMcPUnqDkx4QewNJ2OBZWOm95CORCtLSfOzS26wO6YGDKTIHCkrH/ZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884161; c=relaxed/simple;
	bh=WFeTvzRXST40s/+gu/XHm2qFlrewTQycOh9VzOIVnJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFC9FhqZKT81iQXbXy2QaQ6GdsZPpqWfRH3MUmOHiXNvakDtsdRH3ScHuT9o0HUprcbES0H+IH33x62AgkmSqAbbRvOEvgJPxRJxPfHHxpbkosgyCFKvO4IliESKfdEDVZVpXbRuDyv1cg+41PpEZKVeGRzA2T6fU1qxi+zsZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GM7iSm54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35300C2BD10;
	Tue, 23 Apr 2024 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713884161;
	bh=WFeTvzRXST40s/+gu/XHm2qFlrewTQycOh9VzOIVnJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GM7iSm54s9Oh3xoGEQNExrgIuiJoesMNzNhx5IPuVhwN3PKOv+E6TCV21pB4YdcZg
	 CkIjFDfhH1/6fkjKdnQTKA1cYt1pWGDlQYcNtKAoWMklNeLXLCSULFBNNLwYqRWj17
	 iUGNdnRQvVCB8241vq/cijEy6URvTnw/gM+UskYo=
Date: Tue, 23 Apr 2024 07:55:42 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Fix case when index is reused during tree
 transformation
Message-ID: <2024042318-radio-concept-9a0b@gregkh>
References: <20240423144155.10219-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423144155.10219-1-almaz.alexandrovich@paragon-software.com>

On Tue, Apr 23, 2024 at 05:41:54PM +0300, Konstantin Komarov wrote:
> Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/ntfs3/index.c | 6 ++++++
>  1 file changed, 6 insertions(+)

I know I can't take patches without any changelog text, and odds are you
shouldn't either...

thanks,

greg k-h

