Return-Path: <linux-fsdevel+bounces-63935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EABBD1FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE11898D1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5212F3633;
	Mon, 13 Oct 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a98t5npJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE72F28F0;
	Mon, 13 Oct 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343546; cv=none; b=WJFtE/uU9JDpaHcqe0E7/mWTcLf8Aq34r2T5U85LBqHDH3WLEa5NAxrXrE/DzAvWFXn+W6H1Ds2DVUZ9O8t01WWA72JClRS++pmjaIeBBJXAVdf7xIg8A+NtfcbGRYrVml3a4NN4AjJ9o/E2R5G65AblOyJYIzr+SOerJq0Q+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343546; c=relaxed/simple;
	bh=ljQ4j9Pz6Hncku4QWYc6uskMl5cg5GjeIdqG3a1O4kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAxccYUPNzv1+fNngNRD9XKcew6CocG4EK/l7A6ehkhWgn/njV8SaS8CQRAmOiQ2vntkXaX3oCRJawUUrp6xPdFFmwo+TLW0c785Wg26esnh+Ts4wIBNGRvKDVDMNSw64Hv2IvS6XEAhAz0QFIJMk6ORoUdti1ls5vZQ1dmi8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a98t5npJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A26C4CEFE;
	Mon, 13 Oct 2025 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760343546;
	bh=ljQ4j9Pz6Hncku4QWYc6uskMl5cg5GjeIdqG3a1O4kI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a98t5npJJxA0RJV0qsmNA99531rbeFhI9GCV5Nhm8c3l8Se+sNXDDv4NaKtx8qXjx
	 mYVxDcykicQUWeTF/7HfZFk91uHV3VGoOtjkAyFpmHYPwg3ldZ63R2pu2Z2VhlyFqv
	 isgTahZdLMc7pBZzsN8e0+q7JVVIkQqjansZ++RQ+tcwm3SnnKjHk/mdNkPM+3YOxw
	 uhKKLFud+BtR7TYveS6u94Jl/qVItX1ZfGqjGMnJVUYTvqJhFTdXkNHWugrL628awG
	 eVmkEfNY7U6eHRhr30I+EKehBZIoit3IG1lZhOvcYrwAOE9sAQqTNgFaQplwImdWkt
	 s8JSCF07WNolg==
Message-ID: <74ddf437-0d59-4008-85ea-da6f0f6c0c9c@kernel.org>
Date: Mon, 13 Oct 2025 17:19:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into
 start_delalloc_inodes
To: Daniel Vacek <neelx@suse.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-6-hch@lst.de>
 <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
 <CAPjX3FdRvkie6XMvAjSXb4=8bcjeg1qNjYVT5KOBUDrc+H=nDQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAPjX3FdRvkie6XMvAjSXb4=8bcjeg1qNjYVT5KOBUDrc+H=nDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 17:15, Daniel Vacek wrote:
> On Mon, 13 Oct 2025 at 09:56, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 2025/10/13 11:58, Christoph Hellwig wrote:
>>> In preparation for changing the filemap_fdatawrite_wbc API to not expose
>>> the writeback_control to the callers, push the wbc declaration next to
>>> the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to
>>
>> s/thr/the
>>
>>> start_delalloc_inodes.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> ...
>>
>>> @@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
>>>                              &fs_info->delalloc_roots);
>>>               spin_unlock(&fs_info->delalloc_root_lock);
>>>
>>> -             ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
>>> +             ret = start_delalloc_inodes(root, nr_to_write, false,
>>> +                             in_reclaim_context);
>>>               btrfs_put_root(root);
>>> -             if (ret < 0 || wbc.nr_to_write <= 0)
>>> +             if (ret < 0 || nr <= 0)
>>
>> Before this change, wbc.nr_to_write will indicate what's remaining, not what you
>> asked for. So I think you need a change like you did in start_delalloc_inodes(),
>> no ?
> 
> I understand nr is updated to what's remaining using the nr_to_write
> pointer in start_delalloc_inodes(). Right?

Oh! Yes, nr_to_write points to nr... Sorry about the noise.

So Reviewed-by: Damien Le Moal <dlemoal@kernel.org>



-- 
Damien Le Moal
Western Digital Research

