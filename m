Return-Path: <linux-fsdevel+bounces-44489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B992A69CFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E42426252
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 23:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A72253BA;
	Wed, 19 Mar 2025 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q+zJaD5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222D1DE3A9;
	Wed, 19 Mar 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428702; cv=none; b=RXJm0eYgEzTrzNxukvGjmWFame/uNzATeuuEp03JZkYfGq4B//dMqhC1AprfNf6ZzycTeS+UK10qis6se0jHDw1u7j/AqlyMvTOC7E4MAlZrKI1joWYEVQaASzsHPP1hykc+7uQnxPppSLimGIJ0YVAXnJ105AeJxiwJLxo8k18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428702; c=relaxed/simple;
	bh=rSoECxcX9b+KRE1xg6jEVohUbJ3UCjA1B7aestxTcxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltAe43yX/MwUjLmIJ+JOay2wecmLGS7IKurla7Gg2l5jwDf8PD7h5QZbX+0j0eDJRCuQbcHC7jOBxPLJSGDNoDD3dFpda0/wAl9j8bUeGuB6t0/set5DbxlE8ZA+n8A8jdHulQTDpIpOUTaPKp3ID2+oTWkuuRDL4yK2uFa9IFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q+zJaD5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDC3C4CEE4;
	Wed, 19 Mar 2025 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742428701;
	bh=rSoECxcX9b+KRE1xg6jEVohUbJ3UCjA1B7aestxTcxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+zJaD5ZkbHyP65BU62zb0Z09w1g8gdTKWaro2JmheI6rghm/wSVjxss59SjF+HkY
	 ghX1cHNnun2clJl+F8/XZIGBHM8Shbn5pDWMl5zoX/DWIMP6mbWkDdI+KYvtYL60o5
	 exXZV9mru0SWOyahtPKOPl1WAimpdJ/TO0RkkxfE=
Date: Wed, 19 Mar 2025 16:57:02 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrei Vagin <avagin@gmail.com>, David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jann Horn <jannh@google.com>, Juan Yescas <jyescas@google.com>,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	criu@lists.linux.dev,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <snorcht@gmail.com>,
	Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
Message-ID: <2025031926-engraved-footer-3e9b@gregkh>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
 <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
 <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
 <CANaxB-yMBSFeYcTr-PaevooSeHUkCN9GWTUkLZUNW2vxKzm0sg@mail.gmail.com>
 <10c3e304-1a6d-45ac-a3ad-7c0c8d00e03f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10c3e304-1a6d-45ac-a3ad-7c0c8d00e03f@lucifer.local>

On Wed, Mar 19, 2025 at 07:12:45PM +0000, Lorenzo Stoakes wrote:
> +cc Greg for stable question
> 
> On Wed, Mar 19, 2025 at 11:22:40AM -0700, Andrei Vagin wrote:
> > On Mon, Feb 24, 2025 at 2:39 AM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > On 24.02.25 11:18, Lorenzo Stoakes wrote:
> 
> [snip]
> > > >>
> > > >> Acked-by: David Hildenbrand <david@redhat.com>
> > > >
> > > > Thanks! :)
> > > >>
> > > >> Something that might be interesting is also extending the PAGEMAP_SCAN
> > > >> ioctl.
> > > >
> > > > Yeah, funny you should mention that, I did see that, but on reading the man
> > > > page it struck me that it requires the region to be uffd afaict? All the
> > > > tests seem to establish uffd, and the man page implies it:
> > > >
> > > >         To start tracking the written state (flag) of a page or range of
> > > >         memory, the UFFD_FEATURE_WP_ASYNC must be enabled by UFFDIO_API
> > > >         ioctl(2) on userfaultfd and memory range must be registered with
> > > >         UFFDIO_REGISTER ioctl(2) in UFFDIO_REGISTER_MODE_WP mode.
> > > >
> > > > It would be a bit of a weird edge case to add support there. I was excited
> > > > when I first saw this ioctl, then disappointed afterwards... but maybe I
> > > > got it wrong?
> >
> > > >
> > >
> > > I never managed to review that fully, but I thing that
> > > UFFD_FEATURE_WP_ASYNC thingy is only required for PM_SCAN_CHECK_WPASYNC
> > > and PM_SCAN_WP_MATCHING.
> > >
> > > See pagemap_scan_test_walk().
> > >
> > > I do recall that it works on any VMA.
> > >
> > > Ah yes, tools/testing/selftests/mm/vm_util.c ends up using it for
> > > pagemap_is_swapped() and friends via page_entry_is() to sanity check
> > > that what pagemap gives us is consistent with what pagemap_scan gives us.
> > >
> > > So it should work independent of the uffd magic.
> > > I might be wrong, though ...
> >
> >
> > PAGEMAP_SCAN can work without the UFFD magic. CRIU utilizes PAGEMAP_SCAN
> > as a more efficient alternative to /proc/pid/pagemap:
> > https://github.com/checkpoint-restore/criu/blob/d18912fc88f3dc7bde5fdfa3575691977eb21753/criu/pagemap-cache.c#L178
> >
> 
> Yeah we ascertained that - is on my list, LSF coming up next week means we
> aren't great on timing here, but I'll prioritise this. When I'm back.
> 
> > For CRIU, obtaining information about guard regions is critical.
> > Without this functionality in the kernel, CRIU is broken. We probably should
> > consider backporting these changes to the 6.13 and 6.14 stable branches.
> >
> 
> I'm not sure on precedent for backporting a feature like this - Greg? Am
> happy to do it though.

If it's a regression, sure, we can take it for stable.

> As a stop gap we can backport the pagemap feature if Greg feels this is
> appropriate?

Which do the maintainers of the code feel is appropriate?  I'll defer to
them for making that call :)

thanks,

greg k-h

