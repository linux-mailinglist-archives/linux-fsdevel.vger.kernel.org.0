Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11194EBA44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 07:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiC3FnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiC3Fmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:42:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5F23456F;
        Tue, 29 Mar 2022 22:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U3pUixfOOyFDbSr6FLtB7sBVi31jP+6M8OaYOXBoQgY=; b=YgkVogJU/RAOp5Vbz1tQf4mfAl
        twoURvNPtgJv/390tOp5vwOPGOjLzJH0kO4pcTfkrhAL82DiizugQQzJRhGU4FtAzw8R5Ht3Sx2PC
        nVusu3NraQKshMa4PCspAXFM2QJPCrMsa0hQsLSywVYRBfV1g7CXIvbqJm4IYybionOqFDrPR0lJi
        j7uOFnfl7ZLiepwL7kFDz0xDg7BmAL5FYiw1PpMQnpLivu60/US0g2KD155oDYyBwtveVWTx6AMjA
        GmzFDlZ6AQ8+yoYdyNhh/PD7/b9QDrqVzsVvpf0GPO67LyTKNVUS7QLSTfNgFheLe4dymNKMKm5I9
        5T9W6GQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZR4q-00EMY0-QJ; Wed, 30 Mar 2022 05:41:04 +0000
Date:   Tue, 29 Mar 2022 22:41:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
Message-ID: <YkPtcJdP4s0m17hY@infradead.org>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 03:35:13PM -0800, Dan Williams wrote:
> > +       if (!dax_dev->holder_ops) {
> > +               rc = -EOPNOTSUPP;
> 
> I think it is ok to return success (0) for this case. All the caller
> of dax_holder_notify_failure() wants to know is if the notification
> was successfully delivered to the holder. If there is no holder
> present then there is nothing to report. This is minor enough for me
> to fix up locally if nothing else needs to be changed.

The caller needs to know there are no holder ops to fall back to
different path.

> Isn't this another failure scenario? If kill_dax() is called while a
> holder is still holding the dax_device that seems to be another
> ->notify_failure scenario to tell the holder that the device is going
> away and the holder has not released the device yet.

Yes.
