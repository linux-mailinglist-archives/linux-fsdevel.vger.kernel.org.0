Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB901760D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgCBROd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 12:14:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBROc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j2hxqpKaUS+Roc4f5i/Vccd0HuWME03vKc4/t6bqvZU=; b=WzhlaRqkrARIRkhmc9tWzVFJru
        i7i9Mnd6DjL0eCkjZCR93mH7tw1DArkNfxnqD/UZBPA2EMwBYaWir3uj/9HwHyhreByb0cbdrid58
        /36LpKspqV4ECkhnZKXAresU2d+xpiUm9/yeUIe3cDFg2TmjkJ2bX4/vScW8YZZ1vfK2a61ciZHiS
        5Bb9GZ7mbOUjrtIk1ZQY+mjbiwiMWDNl2qV6ed7fiSvcLL06sysh6IJ4onP146So5JuZnbSZ8Pj/n
        bdCjT7qXl85BPYOqIXHe4cuUSEyh48bGL5/OsUs68gnlYIIFeGR4DKJuWAvHm+OwgjOCSAu+CymcJ
        uzCreRSQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8oeF-0005xZ-8l; Mon, 02 Mar 2020 17:14:31 +0000
Date:   Mon, 2 Mar 2020 09:14:31 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     lampahome <pahome.chen@mirlab.org>, linux-fsdevel@vger.kernel.org
Subject: Re: why do we need utf8 normalization when compare name?
Message-ID: <20200302171431.GQ29971@bombadil.infradead.org>
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302125432.GP29971@bombadil.infradead.org>
 <20200302152818.GN23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302152818.GN23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 03:28:18PM +0000, Al Viro wrote:
> Why the hell do we need case-insensitive filesystems in the first place?
> I have only heard two explanations:
> 	1) because the layout (including name equivalences) is fixed by
> some OS that happens to be authoritative for that filesystem.  In that
> case we need to match the rules of that OS, whatever they are.  Unicode
> equivalence may be an interesting part of _their_ background reasons
> for setting those rules, but the only thing that really matters is what
> rules have they set.
> 	2) early Android used to include a memory card with VFAT on
> it; the card is long gone, but crapplications came to rely upon having
> that shit.  And rather than giving them a file on the normal filesystem
> with VFAT image on it and /dev/loop set up and mounted, somebody wants
> to use parts of the normal (ext4) filesystem for it.  However, the
> same crapplications have come to rely upon the case-insensitive (sensu
> VFAT) behaviour there, so we must duplicate that vomit-inducing pile
> of hacks on ext4.  Ideally - with that vomit-induc{ing,ed} pile
> reclassified as a generic feature; those look more respectable.
> 
> (1) is reasonable enough, but belongs in specific weird filesystems.
> (2) is, IMO, a bad joke.
> 
> Does anybody know of any other reasons?

I've heard it was primarily developed to help port an ecosystem known
for prioritising shipping-on-time over quality-of-code from Windows to
Linux.  I'm not sure why a variant of #2 wasn't a solution they used.
I'm not a fan of having case-insensitive unicode tables in the kernel.
