Return-Path: <linux-fsdevel+bounces-15462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348488ECCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAF42990F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55314D2B4;
	Wed, 27 Mar 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lyan0XKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53412E1F0;
	Wed, 27 Mar 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561211; cv=none; b=DefaHdq3BTh2bEImWUWaJED67SbWbohjzGec8h67/qS9AgfuTWog7PgGgL+rxp1tgcdiVLxR9Ky1yCRAN9dGwvhc/CN9H5BVokA5T3J7lbXZLd6DcbrptNdVbPMN7NheTiomTs4KesUnt2ymAgIfqqOaqfSHIcbReqvm1I6CSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561211; c=relaxed/simple;
	bh=I6x60ia+rggB1OgVHo+pcCe2/5EmZUntXUlWS6xFGsQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m5cb3blqgbItv5QQMCzeIEwIVmCJU+Tz05RpnNoFAL43GT0X8ezwQ01gbqDs3jtWLcEuU3glxZiCZFgenKfLMqUaobQuW7WwjBxGdHcJPbPjaQUGv5yZZy+xSCsTBxJD/6u60iGPs4rD46r1Z2QSsjRxGZFeTuBzubk3W5mNkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lyan0XKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2EFC433C7;
	Wed, 27 Mar 2024 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711561211;
	bh=I6x60ia+rggB1OgVHo+pcCe2/5EmZUntXUlWS6xFGsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lyan0XKkyPAmuDpmWQRdO4kPwUWsHKKFPRzR+jFMTZhBNdgDY1mzOh8Zvhp4h94Hf
	 VQ0ynNWRsVmi8yXVhWA+xbqA28k23Dd1JQMjKNX4Jw0ahspmVHeKybdifIdb4XAofD
	 UjdseAN13zD79wSDoh/4LweFnooobhxtunWjgEkM=
Date: Wed, 27 Mar 2024 10:40:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, jack@suse.cz, bfoster@redhat.com, tj@kernel.org,
 dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-Id: <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
In-Reply-To: <20240327155751.3536-1-shikemeng@huaweicloud.com>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 23:57:45 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> This series tries to improve visilibity of writeback.

Well...  why?  Is anyone usefully using the existing instrumentation? 
What is to be gained by expanding it further?  What is the case for
adding this code?

I don't recall hearing of anyone using the existing debug
instrumentation so perhaps we should remove it!

Also, I hit a build error and a pile of warnings with an arm
allnoconfig build.

