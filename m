Return-Path: <linux-fsdevel+bounces-12527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC08608A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 03:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536381C222A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A5BA34;
	Fri, 23 Feb 2024 02:01:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F72B65F;
	Fri, 23 Feb 2024 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653660; cv=none; b=mNwnNQXMNY+w5xFHjsMPy5GxK35xh0QpAxH3tsvpGtxiBMmG6X1kef3jFoVdxbwVrc4WgN2qqtCaHzXwBFkq45ZwqMXGe+4SgLmkKpuMRWNaiQBcS8knFO3xt7zCsKwunxktXhVa8yq+SsaXZPRW78/wGRueGi32Mq6+wPMcQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653660; c=relaxed/simple;
	bh=tJiSDAP6ww9IEiLJBdFQMRvh+Pqs9jlbiF9Qlg7Fqa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FDjMQtNb8EjQChZlWcE8GUO/Ge+thYGRVH1cZbYWkCBIQdLdPPyFtq3DeZa78pMqDAmQtJPfvsO5n4iZXqpz0q8DiZXvu2QH/zqr1Tj5j6V73veNlVaHay8maP1KRgArvm1jO9AwN62HuDtq4C9QeosbRLJFE8YdauY42Sq7vEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id C7B95233BA7E;
	Fri, 23 Feb 2024 10:52:14 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41N1qDIW204627
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:52:14 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41N1qDo8963449
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:52:13 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 41N1qCr5963448;
	Fri, 23 Feb 2024 10:52:12 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <20240222203013.2649457-1-cascardo@igalia.com> (Thadeu Lima de
	Souza Cascardo's message of "Thu, 22 Feb 2024 17:30:13 -0300")
References: <20240222203013.2649457-1-cascardo@igalia.com>
Date: Fri, 23 Feb 2024 10:52:12 +0900
Message-ID: <87bk88oskz.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

> The tools used for creating images for the Lego Mindstrom EV3 are not
> adding '.' and '..' entry in the 'Projects' directory.
>
> Without this fix, the kernel can not fill the inode structure for
> 'Projects' directory.
>
> See https://github.com/microsoft/pxt-ev3/issues/980
> And https://github.com/microsoft/uf2-linux/issues/6
>
> When counting the number of subdirs, ignore .. subdir and add one when
> setting the initial link count for directories. This way, when .. is
> present, it is still accounted for, and when neither . or .. are present, a
> single link is still done, as it should, since this link would be the one
> from the parent directory.
>
> With this fix applied, we can mount an image with such empty directories,
> access them, create subdirectories and remove them.

This looks like the bug of those tools, isn't it?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

