Return-Path: <linux-fsdevel+bounces-53239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F89AED21A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 03:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DAE3B479F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 01:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316F433AD;
	Mon, 30 Jun 2025 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A229tJ1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0A8479;
	Mon, 30 Jun 2025 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751245419; cv=none; b=AqZ/6X8efQWGqnAEWBoVs0n8glZOAYYy3OJdYWO1a4EmyUoAgrTopr64RYQCvjuGSHlpleeIdm85nW+iZ4xIgNP39UGbqVbuS4m/MvzTBxUy3Sp4hujAggyKAcgiYBf5Eo5yaEKyz7n3NCrm3My2BrhHi2N9sTmRMJNgNJ046eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751245419; c=relaxed/simple;
	bh=D24S1QGo63Mvn+RPZq3ItemdRDY0yJs6VmQvMVfkjw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mF9QqCy3O7c4JhI8jD7VZkV9i3Z1iQnfzxu2KzFVCBLHC3FbTcu6GqCSx/60G70r4o+e598xhx57kEMxiYzh6aSJre6JWSKN43qB2n63LQdU+3FppDouiAg0Fpozch5dd94k+SP3Il3fJkmfccQdSYKKo0+kR2utiGORcZm0200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A229tJ1I; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751245409; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=KE5Ke26crJ20g62CV0eTsdMDqmR58zlWRKiqOi/7eNA=;
	b=A229tJ1I9ClWjaUj2mVAGYIsqG/1dWVSyjCT5ywnSgnvNcQv4qO/ysMvD8Q6qcbSwAoWCVvm46UhZ0vBagIZ1spumsIzfM+naijTKEG6jfk0QlqfUxANdEBtP7jnUaqjHfPANkkeV3/dE5Gh1FgLa/rSRKPGZXL0MwuZ6pJWnq0=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wg25R9f_1751245082 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 08:58:04 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,  Zi Yan <ziy@nvidia.com>,  Matthew
 Wilcox <willy@infradead.org>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  virtualization@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Jonathan Corbet <corbet@lwn.net>,  Madhavan
 Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>,
  Nicholas Piggin <npiggin@gmail.com>,  Christophe Leroy
 <christophe.leroy@csgroup.eu>,  Jerrin Shaji George
 <jerrin.shaji-george@broadcom.com>,  Arnd Bergmann <arnd@arndb.de>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matthew Brost
 <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,  Rakie
 Kim <rakie.kim@sk.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam
 R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Mike Rapoport <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
  Michal Hocko <mhocko@suse.com>,  Minchan Kim <minchan@kernel.org>,
  Sergey Senozhatsky <senozhatsky@chromium.org>,  Brendan Jackman
 <jackmanb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Jason
 Gunthorpe <jgg@ziepe.ca>,  John Hubbard <jhubbard@nvidia.com>,  Peter Xu
 <peterx@redhat.com>,  Xu Xin <xu.xin16@zte.com.cn>,  Chengming Zhou
 <chengming.zhou@linux.dev>,  Miaohe Lin <linmiaohe@huawei.com>,  Naoya
 Horiguchi <nao.horiguchi@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Rik van Riel <riel@surriel.com>,  Harry Yoo <harry.yoo@oracle.com>,  Qi
 Zheng <zhengqi.arch@bytedance.com>,  Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
In-Reply-To: <nr4e7unt2dtfav5y5ckmsrehu37xejqonarlulzcn6mnhnnvxl@o3ppo34wqyyj>
	(Alistair Popple's message of "Mon, 30 Jun 2025 10:20:56 +1000")
References: <20250618174014.1168640-1-david@redhat.com>
	<20250618174014.1168640-8-david@redhat.com>
	<9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
	<aFMH0TmoPylhkSjZ@casper.infradead.org>
	<4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
	<bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
	<87h5zyrdl9.fsf@DESKTOP-5N7EMDA>
	<nr4e7unt2dtfav5y5ckmsrehu37xejqonarlulzcn6mnhnnvxl@o3ppo34wqyyj>
Date: Mon, 30 Jun 2025 08:58:03 +0800
Message-ID: <878qlaqc4k.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alistair Popple <apopple@nvidia.com> writes:

> On Sun, Jun 29, 2025 at 07:28:50PM +0800, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>> > On 18.06.25 20:48, Zi Yan wrote:
>> >> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
>> >> 
>> >>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>> >>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>> >>>>
>> >>>>> ... and start moving back to per-page things that will absolutely not be
>> >>>>> folio things in the future. Add documentation and a comment that the
>> >>>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>> >>>>>
>> >>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>> >>>>> it gracefully (relevant with further changes), and convert a
>> >>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>> >>>>
>> >>>> The reason is that there is no upstream code, which use movable_ops for
>> >>>> folios? Is there any fundamental reason preventing movable_ops from
>> >>>> being used on folios?
>> >>>
>> >>> folios either belong to a filesystem or they are anonymous memory, and
>> >>> so either the filesystem knows how to migrate them (through its a_ops)
>> >>> or the migration code knows how to handle anon folios directly.
>> >
>> > Right, migration of folios will be handled by migration core.
>> >
>> >> for device private pages, to support migrating >0 order anon or fs
>> >> folios
>> >> to device, how should we represent them for devices? if you think folio is
>> >> only for anon and fs.
>> >
>> > I assume they are proper folios, so yes. Just like they are handled
>> > today (-> folios)
>
> Yes, they should be proper folios.

So, folios include file cache, anonymous, and some device private.

>> > I was asking a related question at LSF/MM in Alistair's session: are
>> > we sure these things will be folios even before they are assigned to a
>> > filesystem? I recall the answer was "yes".
>> >
>> > So we don't (and will not) support movable_ops for folios.
>> 
>> Is it possible to use some device specific callbacks (DMA?) to copy
>> from/to the device private folios (or pages) to/from the normal
>> file/anon folios in the future?
>
> I guess we could put such callbacks on the folio->pgmap, but I'm not sure why
> we would want to. Currently all migration to/from device private (or coherent)
> folios is managed by the device, which is one of the features of ZONE_DEVICE.

Yes.  The is the current behavior per my understanding too.

> Did you have some particular reason/idea for why we might want to do this?

No.  Just want to check whether there are some requirements for that.  I
think that it's just another way to organize code.

---
Best Regards,
Huang, Ying

