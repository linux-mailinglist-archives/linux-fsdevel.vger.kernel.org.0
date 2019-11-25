Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D3410938E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 19:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfKYSdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 13:33:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41681 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfKYSdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:33:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so17071872ljj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kPjtxI/TrF4UnMikjlggsxMbTRpW7xiQMfu1Q1pQSto=;
        b=15Bpu0X6m1bgIwc9pGxLJZIxvfZTaxrG3jlKJDzx9i0BU/czx4OvuotVSORu/UJMHA
         5xAzIKc+sBj6fQJq7T5O+9lHX1m2VhKwfkd0yD8vRmCSzrz2q3HitQYPUdT/0O5TqWNW
         lWITqzgChNWXPkzX5ejQHEnESq/ytb4CupHwGgWuqWuzEz2CIZfIbGGXxW49d02VEAaJ
         ajqTbNbaTb3Q7BjdqUbyjB12Qx9qfQUbA0u7ndYqDInYEz75ynlU29iGTUEonXISUMRf
         y1zDm0i3Wt4IK0Ndyr337xWNITXajNPS9NHKNamlJbrqEiUGGwadbe4Yf5ktuPmKK6iA
         XFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kPjtxI/TrF4UnMikjlggsxMbTRpW7xiQMfu1Q1pQSto=;
        b=rrKlzybw9bTz022jQzs2OnhwwwJhDLdDh1RvB9P+AqNkodiArH00k7dCkeeiywma6m
         ZukJcoedgjB66bNMEhxSHiMsboH/huFJ5M2WkdEBRGRrb4vTbPwoLEeHMS4qMSlh6lnq
         sAz1jfDvkE1IA1/Zv1CuG87RkiXxo8b0GgyaMaIu6z2OH2MaSfPXJyQJdrfgCKoMTPux
         bGwWXll2U5kwL/Vl/QtNHpbH/c3xqsj9vXjQ7eOJ3lsefYfYBb8/St8lJxJ6UDpBud9o
         BWIfTbAZ1fEjW/8jm0L9WEazyvQ92+B81QIJWdGSNl2Knghc/bivPBwueob9cC7p12hF
         lNeg==
X-Gm-Message-State: APjAAAU9WHF65362j+NbfPT2dgi7tyAUfVijEJH55dnGuWNG/a4Wg2DB
        v0nLLdt17wG/+iBKtWHSoH1mJA==
X-Google-Smtp-Source: APXvYqytq8uQHbgkfOudQHi3MYcOIVXdIxAHGRYx6WisuZYKhE/mnmwsQkgLfFth9cwc6u+RUlHkjw==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr23663505ljk.78.1574706822066;
        Mon, 25 Nov 2019 10:33:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n19sm4019290lfl.85.2019.11.25.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 10:33:41 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B23951032C4; Mon, 25 Nov 2019 21:33:50 +0300 (+03)
Date:   Mon, 25 Nov 2019 21:33:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
Message-ID: <20191125183350.5gmcln6t3ofszbsy@box>
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191125093611.hlamtyo4hvefwibi@box>
 <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 10:24:38AM -0800, Yang Shi wrote:
> 
> 
> On 11/25/19 1:36 AM, Kirill A. Shutemov wrote:
> > On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
> > > Currently when truncating shmem file, if the range is partial of THP
> > > (start or end is in the middle of THP), the pages actually will just get
> > > cleared rather than being freed unless the range cover the whole THP.
> > > Even though all the subpages are truncated (randomly or sequentially),
> > > the THP may still be kept in page cache.  This might be fine for some
> > > usecases which prefer preserving THP.
> > > 
> > > But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> > > or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> > > So, when using shmem THP as memory backend QEMU inflation actually doesn't
> > > work as expected since it doesn't free memory.  But, the inflation
> > > usecase really needs get the memory freed.  Anonymous THP will not get
> > > freed right away too but it will be freed eventually when all subpages are
> > > unmapped, but shmem THP would still stay in page cache.
> > > 
> > > To protect the usecases which may prefer preserving THP, introduce a
> > > new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting THP is
> > > preferred behavior if truncating partial THP.  This mode just makes
> > > sense to tmpfs for the time being.
> > We need to clarify interaction with khugepaged. This implementation
> > doesn't do anything to prevent khugepaged from collapsing the range back
> > to THP just after the split.
> 
> Yes, it doesn't. Will clarify this in the commit log.

Okay, but I'm not sure that documention alone will be enough. We need
proper design.

> > > @@ -976,8 +1022,31 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> > >   			}
> > >   			unlock_page(page);
> > >   		}
> > > +rescan_split:
> > >   		pagevec_remove_exceptionals(&pvec);
> > >   		pagevec_release(&pvec);
> > > +
> > > +		if (split && PageTransCompound(page)) {
> > > +			/* The THP may get freed under us */
> > > +			if (!get_page_unless_zero(compound_head(page)))
> > > +				goto rescan_out;
> > > +
> > > +			lock_page(page);
> > > +
> > > +			/*
> > > +			 * The extra pins from page cache lookup have been
> > > +			 * released by pagevec_release().
> > > +			 */
> > > +			if (!split_huge_page(page)) {
> > > +				unlock_page(page);
> > > +				put_page(page);
> > > +				/* Re-look up page cache from current index */
> > > +				goto again;
> > > +			}
> > > +			unlock_page(page);
> > > +			put_page(page);
> > > +		}
> > > +rescan_out:
> > >   		index++;
> > >   	}
> > Doing get_page_unless_zero() just after you've dropped the pin for the
> > page looks very suboptimal.
> 
> If I don't drop the pins the THP can't be split. And, there might be more
> than one pins from find_get_entries() if I read the code correctly. For
> example, truncate 8K length in the middle of THP, the THP's refcount would
> get bumpped twice since  two sub pages would be returned.

Pin the page before pagevec_release() and avoid get_page_unless_zero().

Current code is buggy. You need to check that the page is still belong to
the file after speculative lookup.

-- 
 Kirill A. Shutemov
