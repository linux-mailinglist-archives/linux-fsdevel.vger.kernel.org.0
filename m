Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC4E2ABA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437868AbfJXHEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 03:04:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXHEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UuKLDbpQvbMotGXcc+uLQ0Vocvzd2LHIJ9vtxHOU5vU=; b=i6E3AhTxU7PiiGoZzHX1bpT6K
        7IRuf91wXcARc4dhTksYxqxPdfUSlbB4q7yGugACfQTvkbN8suN7Yd9H8ZiWfzixEAaJEUoGg497V
        8lWSw8TWXat6lhpSQCxuXB0JIQp15oSX7lw7dgZ6tsSiYPOWh+odehSxcdiZJEy7yrEN1UoQISKC+
        KihqDHF2wWd5cKKq/bFaRJ4aOtR9PXq7IR4CzsUOxkrN9XW5Z5UkWpZkzqAoSh6m6C8RzC/j/5MRy
        CLVwiG+QvZ8C4mNC7/+ocWKE0wCHvQZXxoKj2reDkv5OQNW6+OzL+JyxSmVy2pIlCdVqbRt89NrZ1
        P+5IiNmTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNXAf-0004zo-44; Thu, 24 Oct 2019 07:04:33 +0000
Date:   Thu, 24 Oct 2019 00:04:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191024070433.GB16652@infradead.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
 <20191022133001.GA23268@mit.edu>
 <20191023092718.GA23274@infradead.org>
 <20191023125701.GA2460@mit.edu>
 <20191024012759.GA32358@infradead.org>
 <20191024024459.GA743@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024024459.GA743@sol.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 07:44:59PM -0700, Eric Biggers wrote:
> Would you be happy with something that more directly describes the change the
> flag makes

Yes.

> , like FSCRYPT_POLICY_FLAG_CONTENTS_IV_INO_LBLK_64?  I.e., the IVs for
> contents encryption are 64-bit and contain the inode and logical block numbers.
> 
> Actually, we could use the same key derivation and IV generation for directories
> and symlinks too, which would result in just FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64.
> (lblk is 0 when encrypting a filename.)

I think not making it crazy verbose is a helpful, but at the same time
it should be somewhat descriptive.

> Although, in general it would be nice to name the settings in ways that are
> easier for people not intimately familiar with the crypto to understand...

For the andoid case the actual users won't ever really see it, and if
you set up the thing yourself it probably helps a lot to try to
understand what your are doing.
