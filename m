Return-Path: <linux-fsdevel+bounces-57481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83723B22071
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D0B7A7159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707F2E0B64;
	Tue, 12 Aug 2025 08:14:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70924296BDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986448; cv=none; b=glqtsrrcA8rOHWXxXuiZQJRqsY+8q/HM5wwVTPCMmJaeZb+TmhzYotPQDsKHKXOY3AFKNroh409gdorZGcjIwx+kCMgtEokWuqavnNF0Ar5Vj1/+Ylf/UbwtVIDifstV+5gtqICiYm11YKyF+YTPona0iVWWJV4kjjAqNisaLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986448; c=relaxed/simple;
	bh=9w5snlT7EHa/4e9Y0WWd/uyCPzVX8HqOUM0kPbfmXjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP/UQIkiKWQuRbvMJedMKcN3Cm2hnzbqNc/aOFSQUi9x6bwShiGfnrXSv3OWPM0oqTpWVebxq4aICDrZWYqKNfFStowYGwY6ielSam6Jewn99Cbpl7GVFZVF5jMIdxsIiQfTVgY61sAK5TDsUgUvMkjyEXiutqxBiFXOI6NOKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E7CE1F461;
	Tue, 12 Aug 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 534191351A;
	Tue, 12 Aug 2025 08:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QtPcE8v3mmj4YQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 Aug 2025 08:14:03 +0000
Date: Tue, 12 Aug 2025 10:13:58 +0200
From: David Sterba <dsterba@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Message-ID: <20250812081358.GA5507@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 8E7CE1F461
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Aug 11, 2025 at 04:39:48PM +0200, David Hildenbrand wrote:
> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
> 
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c |  2 +-
>  drivers/misc/vmw_balloon.c           |  4 +--
>  drivers/virtio/virtio_balloon.c      |  2 +-
>  fs/aio.c                             |  2 +-

For

>  fs/btrfs/inode.c                     |  4 +--

Acked-by: David Sterba <dsterba@suse.com>

