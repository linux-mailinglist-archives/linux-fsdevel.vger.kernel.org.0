Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C09F21AEC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 07:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgGJFeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 01:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgGJFeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:34:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E98C08C5CE;
        Thu,  9 Jul 2020 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pVjWefAfqShBdQ1ZZJmJ6WwzyFiCXEB2I8I0n7n2VvA=; b=SUHqfj0xDvAG/k3lfL1KEXLiV2
        60PoTII6SdYLTmUHFeNDnuRi4A94mjv0BljVLGMx1uzxIWRZFKA/JoKuVBK/fS9c79Gt1D9WQJEnR
        ax0PRiqaz9VlGLTJ025lM0VOvZRrkcUlPyCJir7j4JfFtwZ4yA3+sxKhQNZuysRJU5L5JQqymDCss
        AiLX10BZ1YGeBBHGHKkXdbT19NKNg4OtqAoM6O7CcpNjxf7II92J/0zFOODZMjzhrrnkQWUetDlS8
        HYwJiW4o1RVw+MrxIY3lMCAI97+j0afkuWH4B81BilyO++t9EKd+qQseW+nQdd7QoigjYp9Y9H47o
        0RlKQclQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtlfi-0006zt-Ec; Fri, 10 Jul 2020 05:34:06 +0000
Date:   Fri, 10 Jul 2020 06:34:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 2/5] direct-io: add support for fscrypt using blk-crypto
Message-ID: <20200710053406.GA25530@infradead.org>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709194751.2579207-3-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 07:47:48PM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Set bio crypt contexts on bios by calling into fscrypt when required,
> and explicitly check for DUN continuity when adding pages to the bio.
> (While DUN continuity is usually implied by logical block contiguity,
> this is not the case when using certain fscrypt IV generation methods
> like IV_INO_LBLK_32).

I know it is asking you for more work, but instead of adding more
features to the legacy direct I/O code, could you just switch the user
of it (I guess this is for f2f2?) to the iomap one?
