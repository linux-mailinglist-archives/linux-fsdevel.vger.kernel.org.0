Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8478F14DF7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 17:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgA3Qy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 11:54:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3Qy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qceikH9PHpCz39hioQYWaZZk7q8XBIPjc6qoISxbbjM=; b=IEtluxk0SuMb5ff+P3zrx0x0Z
        ZDyJL2W+YIXQPZF2BhR1T7j0HbsbhoEMyK/NBw/UiOIiuLJpcb2m/xG5FDzMd5dm1zJi4/LpAYMtl
        i4+TrlEqCOH6Mjr1dXF7PW36pKjEaB1Yc7W9+T8oD7KUeHdyh82rBQEDMKmojpNsQGfTlrQF2xmRh
        P/GkTuDgHHGcdQbdRhUr8Kuec0tFxiPx4mG8soI0bqYR3ufvbJ3R6W7spCFqzO4jwxJe2OJFmJLeg
        GkVE/fS5+SH9N0/DgmISRtEU8xC6+ZSOBvy9SnDTIp+CM7owxeFBT/DYppv32i7t0pNyA5ydEa3fQ
        ymFavt1Mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixD5F-0004ap-68; Thu, 30 Jan 2020 16:54:25 +0000
Date:   Thu, 30 Jan 2020 08:54:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice: direct call for default_file_splice*()
Message-ID: <20200130165425.GA8872@infradead.org>
References: <12375b7baa741f0596d54eafc6b1cfd2489dd65a.1579553271.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12375b7baa741f0596d54eafc6b1cfd2489dd65a.1579553271.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:49:46PM +0300, Pavel Begunkov wrote:
> Indirect calls could be very expensive nowadays, so try to use direct calls
> whenever possible.

... and independent of that your new version is much shorter and easier
to read.  But it could be improved a tiny little bit further:

>  	if (out->f_op->splice_write)
> -		splice_write = out->f_op->splice_write;
> +		return out->f_op->splice_write(pipe, out, ppos, len, flags);
>  	else
> -		splice_write = default_file_splice_write;
> -
> -	return splice_write(pipe, out, ppos, len, flags);
> +		return default_file_splice_write(pipe, out, ppos, len, flags);

No need for the else after an return.

>  	if (in->f_op->splice_read)
> -		splice_read = in->f_op->splice_read;
> +		return in->f_op->splice_read(in, ppos, pipe, len, flags);
>  	else
> -		splice_read = default_file_splice_read;
> -
> -	return splice_read(in, ppos, pipe, len, flags);
> +		return default_file_splice_read(in, ppos, pipe, len, flags);

Same here.
