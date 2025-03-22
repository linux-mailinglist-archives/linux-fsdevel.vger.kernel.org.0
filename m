Return-Path: <linux-fsdevel+bounces-44757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46732A6C797
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 05:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797347A3684
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B3B147C9B;
	Sat, 22 Mar 2025 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cXloBZzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561BAD2D;
	Sat, 22 Mar 2025 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742618255; cv=none; b=WOFHcct90jpWtnh6MH5WoT41uiBnsT3PEgvPrn1BcrJ4BumJ+YI9cyRcxwh0xlB6+E4kY28GdtWN3BZcRb2QA+nrIpWxyHvBnBpP8e8lmEHQkyh9NzJ0OZtfYFM8EGSn14Hf6vEQR8CGnEt6CiBWug4Z2mNTsXaUSy+JEaFVrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742618255; c=relaxed/simple;
	bh=2EcT9oRj1eVirSYNwY+I32OLgi/kxyRa5uOs4hIPc8g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fG7rDcgT1AWBXge8706yQMHJ7j59dTfHDs6aYho4h2aFvW6EdIKpLzed3vFKd8BKrFh29uVrl7yt7xRxGxwHtRhyCij4SIQVof78ct1+RicpcF4u/10LzFlu2TbMOso1Mcc/o6MkeEFQ/5fAsoh441kFfk+C3vB+UN9gswuXd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cXloBZzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFEBC4CEDD;
	Sat, 22 Mar 2025 04:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742618254;
	bh=2EcT9oRj1eVirSYNwY+I32OLgi/kxyRa5uOs4hIPc8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cXloBZzYzyc/uyKQy2ozZBxUcEGTQ0a6LeMMmnxvsyNP470Lbv2fg1NpeZGpdzvEO
	 G3aGJ44BbETaFVVZYeTJLEO7/Fc6phDT6BOlV8n47TbQasEAfOUiN8wzora/2CyDE5
	 bhd+T3CcWNp3IdP/7ETqeDcGLSLTUD8RNccjXOfk=
Date: Fri, 21 Mar 2025 21:37:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] XArray: revert (unintentional?) behavior change
Message-Id: <20250321213733.b75966312534184c6d46d6aa@linux-foundation.org>
In-Reply-To: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>
References: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 22:17:08 -0400 Tamir Duberstein <tamird@gmail.com> wrote:

> Partially revert commit 6684aba0780d ("XArray: Add extra debugging check
> to xas_lock and friends"), fixing test failures in check_xa_alloc.
> 
> Fixes: 6684aba0780d ("XArray: Add extra debugging check to xas_lock and friends")

Thanks.

6684aba0780d appears to be only in linux-next.  It has no Link: and my
efforts to google its origin story failed.  Help?

