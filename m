Return-Path: <linux-fsdevel+bounces-50781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244CAACF883
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 22:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C555189E224
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B571FE44B;
	Thu,  5 Jun 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gqiLvvt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7B17548;
	Thu,  5 Jun 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153748; cv=none; b=dZWjsj9j1zm8EXINQkaQXqqQmmr0GxbvnhNg8sGzUwSkXEU5XawK2jJ9TtsoZwEmy3rYtDGM9/JrwqNZWZhc11g2IoJeonAjAgobca0yl9t0aD9jb15Hicg7TMwoX9UT0bZdAf22isO1pqHrsh23EwiwIhMVl221UUz9cF55/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153748; c=relaxed/simple;
	bh=7POy0PwH4blRJ5E1aF7ZF6VZE2R9uGB+oQ4ajtto1xU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iVwBqh7jEwlMqXxlzjFL6LlavgOFevPIqCQ44SJXG7ZVDa2KjylyYs5Mm48H7sqkbknosaMU6PnHqX1Dfo1W8UeV+hiqohzyyuHLopz0vmhY87KnPSn8a9eXO882L5O6xKuz1GbmqrJTTZqXocCrRyrD7/A6dybBb//Sjro4ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gqiLvvt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16542C4CEE7;
	Thu,  5 Jun 2025 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749153748;
	bh=7POy0PwH4blRJ5E1aF7ZF6VZE2R9uGB+oQ4ajtto1xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqiLvvt7+M/LbKMv5+JDSwn9E9h/04p9RPnSOU1ir9l4zi2LQYDkDi4dboD1sQLPj
	 ZmgOjSXyN3gWxVSJiIqZtiuannx9BCweEpn6XqOBntxX+fecPXTqFaoz+/jhhsC1Ga
	 LP/zlWHqzZfSJRTT5syc7sPqJbJwR/uvYv6z06zs=
Date: Thu, 5 Jun 2025 13:02:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] Some random fixes and cleanups to shmem
Message-Id: <20250605130227.f06c8ad8cc6517720d7e0db9@linux-foundation.org>
In-Reply-To: <20250605221037.7872-1-shikemeng@huaweicloud.com>
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Jun 2025 06:10:30 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> This series contains more fixes and cleanups which are made during
> learning shmem. Patch 1-3 are some random fixes; Patch 4-7 are some
> random cleanups. More details can be found in respective patches. Thanks!

Thanks.  I'll skip v1, wait to see what reviewers have to say.  Please
poke me in a week or so if you think I should proceed with the v1 series.


