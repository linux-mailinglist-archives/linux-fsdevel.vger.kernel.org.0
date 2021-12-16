Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2875476B28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 08:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhLPHqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 02:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhLPHqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:46:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD6C061574;
        Wed, 15 Dec 2021 23:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vcE5xITae30eveBT3POA+xHhwo2Q6buP3s15knpDWAk=; b=1NvmtU84iD7rhEWYoHr3V3n88g
        OAJv7aoNOrpLdpLwN8Oz1upyeMGK/mS64MImUsI38e4fdymihSix5zkisblNC5odr4juDFRln35AQ
        EzhZztmT5R5QcInMeeDB5xf3XRyYjdi+efc29SWqeqZkXVbEW39ooh60jz/vKIzSsU7nlldOK0p0/
        ftgA8nvk6MWFFruogKAYWMmVVquHEwUgBJbKRT2wpBOblDRSsQeMhPsnKQf/JGTwwnlBlf/lAOCSJ
        /3iBEI/gRQZS6DLZRwJBFGHWhHKWsgvIMqgVl6T6Y2onPefoluFKObDyY0Q6PSGBnCX4xAq40mGvI
        DFEH4FAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxlTD-0040QN-VT; Thu, 16 Dec 2021 07:46:31 +0000
Date:   Wed, 15 Dec 2021 23:46:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, jane.chu@oracle.com
Subject: Re: [PATCH v8 7/9] dax: add dax holder helper for filesystems
Message-ID: <Ybru12651I+lETBq@infradead.org>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
 <20211202084856.1285285-8-ruansy.fnst@fujitsu.com>
 <Ybi8pmieExZbd/Ee@infradead.org>
 <2c0d1b44-5b7f-f4d0-a7ca-0cf692a0cdd4@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c0d1b44-5b7f-f4d0-a7ca-0cf692a0cdd4@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:21:00AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2021/12/14 23:47, Christoph Hellwig 写道:
> > On Thu, Dec 02, 2021 at 04:48:54PM +0800, Shiyang Ruan wrote:
> > > Add these helper functions, and export them for filesystem use.
> > 
> > What is the point of adding these wrappers vs just calling the
> > underlying functions?
> 
> I added them so that they can be called in a friendly way, even if
> CONFIG_DAX is off.  Otherwise, we need #if IS_ENABLED(CONFIG_DAX) to wrap
> them where they are called.

No need for wrappers, you can stub out the underlying functions as well.
