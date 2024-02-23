Return-Path: <linux-fsdevel+bounces-12551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A471D860CEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFE328111C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28086179A8;
	Fri, 23 Feb 2024 08:32:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E96134AD;
	Fri, 23 Feb 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677171; cv=none; b=JW/Z1vuwrnublDDXKqKH+bI/C3HBqlsI6JIoVW325mpdHRA61uoRUufnEE3UA+3Fc+QMjJzsLuCxCfIzC6PzkFYeQcc5pG7nS3CdTIDODFWxs4SyAFRCd2W7Ua/711waMeRkX57i4tMKdEDzxJuF0BYyB1ilIpgQL9qI+bNFYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677171; c=relaxed/simple;
	bh=2uCLZV0OXklY47DP/SXA/CmaNI0k3CXjhriIgHeMr3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nCf3THooRVZUw2hC74iVu8tQKF4gZy3Vg1ezeY0bn8GhIQkEIHEghSwOkVZUvcpoAfW0Giwo5WlK+CulqSh+IXrVLi8fRK1ZcLBp/QY6jIMb7SLSV35hVM0+AnpQgm6JXpsKsPTl0Mq6j50DlGv1iq3ubHqrc8eR/+GAx9+kj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 81E15233CCB7;
	Fri, 23 Feb 2024 17:32:48 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41N8WlwD212563
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:32:48 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41N8Wl0S1008245
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:32:47 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 41N8WlWk1008244;
	Fri, 23 Feb 2024 17:32:47 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <874jdzpov7.fsf@mail.parknet.co.jp> (OGAWA Hirofumi's message of
	"Fri, 23 Feb 2024 17:27:08 +0900")
References: <20240222203013.2649457-1-cascardo@igalia.com>
	<87bk88oskz.fsf@mail.parknet.co.jp>
	<Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
	<874jdzpov7.fsf@mail.parknet.co.jp>
Date: Fri, 23 Feb 2024 17:32:47 +0900
Message-ID: <87zfvroa1c.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> OK.
>
> If you want to add the workaround for this, it must emulate the correct
> format. I.e. sane link count even if without "."/"..". And furthermore
> it works for any operations.

Of course, it must not affect the correct format. And it should not
accept the other really corrupted format.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

