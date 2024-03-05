Return-Path: <linux-fsdevel+bounces-13577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBE871496
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 05:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD221C21255
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 04:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966553D0B4;
	Tue,  5 Mar 2024 04:14:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627BE611A;
	Tue,  5 Mar 2024 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612063; cv=none; b=R8Qz6dxjL85ZGuo5OaDS4XixSnxbEGDbEHb2kenZjflflwToX6pY+XT3Lc23YrE0OU2W+ZKleaJfRV5dBPghsYa527T8aeUmJp+Mx5esQFF4PsvBd5pQ6mkC/FyEVchvCol3LGRKk3qZqcOS4V3+dKmcwdTg0OsRxjxfV8RKaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612063; c=relaxed/simple;
	bh=TjDJOdzNlS2I+IVQ7fVMlMCc8s38fA479jwMFEYijiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I3+MShm2KIhtQ+n0lrqHviY4nc/cmx16uu5i6xSbpVRUzpIL18qF0YLadMpk9V3rk+53Nn4FKnG134jI66nf6qfWIbeQNkz8sHoNsIn0c7bZr/gRkT7L/hWbVsZye+L0GCeFecVbXMbDMFyN24HxTzObqHiFJN0f/IwTIccZ+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 52C2B2055FA1;
	Tue,  5 Mar 2024 13:14:13 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 4254ECrU145375
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 13:14:13 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 4254ECIY774897
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 13:14:12 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4254EBGd774896;
	Tue, 5 Mar 2024 13:14:11 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <ZeZbMVenoDNOFVik@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Mon, 4 Mar 2024 20:37:21 -0300")
References: <20240222203013.2649457-1-cascardo@igalia.com>
	<87bk88oskz.fsf@mail.parknet.co.jp>
	<Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
	<874jdzpov7.fsf@mail.parknet.co.jp>
	<87zfvroa1c.fsf@mail.parknet.co.jp>
	<ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
	<87v86fnz2o.fsf@mail.parknet.co.jp>
	<Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
	<87le75s1fg.fsf@mail.parknet.co.jp>
	<Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
	<ZeZbMVenoDNOFVik@quatroqueijos.cascardo.eti.br>
Date: Tue, 05 Mar 2024 13:14:11 +0900
Message-ID: <875xy1wc18.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

> On Wed, Feb 28, 2024 at 06:10:29AM -0300, Thadeu Lima de Souza Cascardo wrote:
>> On Wed, Feb 28, 2024 at 12:38:43PM +0900, OGAWA Hirofumi wrote:
>> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
>> > 
>> Checking the filesystem on Windows runs without any complains, but it turns the
>> directory into an useless lump of data. Without checking the filesystem,
>> creating and reading files from that directory works just fine.
>> 
>> I tried to use gzip or xz to compress the very sparse filesystem image that I
>> got, but they made it larger on disk than it really was. So here is a script
>> and pieces of the filesystem that will create a sparse 8GB image.
>> 
>> Thank you for looking into this.
>> Cascardo.
>
> Hi, OGAWA Hirofumi.
>
> What are your thoughts here? Should we make it possible to read such
> filesystems? Is the proposed approach acceptable?

Sorry. I was busy recently, so I didn't have time to check this
yet. When I could make time to check, I will.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

