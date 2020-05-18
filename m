Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6279B1D7137
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 08:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgERGmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 02:42:50 -0400
Received: from verein.lst.de ([213.95.11.211]:37045 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgERGmt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 02:42:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C84E68AFE; Mon, 18 May 2020 08:42:46 +0200 (CEST)
Date:   Mon, 18 May 2020 08:42:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 09/14] fs: don't change the address limit for
 ->write_iter in __kernel_write
Message-ID: <20200518064246.GA19296@lst.de>
References: <20200513065656.2110441-1-hch@lst.de> <20200516030436.19448-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516030436.19448-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 11:04:36AM +0800, Hillf Danton wrote:
> > +	if (file->f_op->write_iter) {
> > +		struct kvec iov = { .iov_base = (void *)buf, .iov_len = count };
> > +		struct kiocb kiocb;
> > +		struct iov_iter iter;
> > +
> > +		init_sync_kiocb(&kiocb, file);
> > +		kiocb.ki_pos = *pos;
> > +		iov_iter_kvec(&iter, WRITE, &iov, 1, count);
> > +		ret = file->f_op->write_iter(&kiocb, &iter);
> > +		if (ret > 0)
> > +			*pos = kiocb.ki_pos;
> > +	} else if (file->f_op->write) {
> > +		mm_segment_t old_fs = get_fs();
> > +
> > +		set_fs(KERNEL_DS);
> 
> Would you please shed light on who need it if a workqueue worker does
> not, given the access to buf? 

Can you rephrase the question, I unfortunately do not understand it at
all as-is.
