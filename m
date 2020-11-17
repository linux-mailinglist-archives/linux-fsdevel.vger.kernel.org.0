Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBF2B6E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgKQTXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 14:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKQTXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:23:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6BC0613CF;
        Tue, 17 Nov 2020 11:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B3qhTz4NCSZ9LglknH7xFdtictVUsmVYC66HuoyyZVM=; b=jFHdhhnkn8DHAiwhj/oakto7LT
        7Xs3yjgYpfYlkYKyA4ncqiqustuuAay52ZW0z0DJnDcBOWTszr3mu99NHToHwZJ577ENuq0LS7af4
        fw+X16kfHNjkrU10jbQyftaoatS+hJn7njW7lDuIQCtTb/fzPXAZdCv7OYI8mGQ8Nl3VYu9CeE/nP
        /eooSCjo3zKSkvt4i557R1MSkpMfOmleSKIGp0GoeeZK2TCekE5mplB5koEb7tgd6qm1FUpP0MZ1B
        l2ZCms11fhiM3PxfzxAR00L7EQdcHYY4pE+yWiwEixcA85HoaejEgK9p9+5fpNbcNz4E3IMLsPXlz
        VkOIdQkA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf6YZ-0005GH-Pn; Tue, 17 Nov 2020 19:22:23 +0000
Date:   Tue, 17 Nov 2020 19:22:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
Message-ID: <20201117192223.GW29991@casper.infradead.org>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <349168819c1249d4bceea26597760b0a@hisilicon.com>
 <CAMZfGtUVDJ4QHYRCKnPTkgcKGJ38s2aOOktH+8Urz7oiVfimww@mail.gmail.com>
 <714ae7d701d446259ab269f14a030fe9@hisilicon.com>
 <CAMZfGtWNa=abZdN6HmWE1VBFHfGCbsW9D0zrN-F5zrhn6s=ErA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWNa=abZdN6HmWE1VBFHfGCbsW9D0zrN-F5zrhn6s=ErA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:29:07AM +0800, Muchun Song wrote:
> > ideally, we should be able to free PageTail if we change struct page in some way.
> > Then we will save much more for 2MB hugetlb. but it seems it is not easy.
> 
> Now for the 2MB HugrTLB page, we only free 6 vmemmap pages.
> But your words woke me up. Maybe we really can free 7 vmemmap
> pages. In this case, we can see 8 of the 512 struct page structures
> has beed set PG_head flag. If we can adjust compound_head()
> slightly and make compound_head() return the real head struct
> page when the parameter is the tail struct page but with PG_head
> flag set. I will start an investigation and a test.

What are you thinking?

static inline struct page *compound_head(struct page *page)
{
        unsigned long head = READ_ONCE(page->compound_head);

        if (unlikely(head & 1))
                return (struct page *) (head - 1);
+	if (unlikely(page->flags & PG_head))
+		return (struct page *)(page[1]->compound_head - 1)
        return page;
}

... because if it's that, there are code paths which also just test
PageHead, and so we'd actually need to change PageHead to be something
like:

static inline bool PageHead(struct page *page)
{
	return (page->flags & PG_head) &&
		(page[1]->compound_head == (unsigned long)page + 1);
}

I'm not sure if that's worth doing -- there may be other things I
haven't thought of.
