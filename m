Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45C16496D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 23:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiLKWmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 17:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiLKWma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:42:30 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A010BC8C;
        Sun, 11 Dec 2022 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ToEbtHR3jULC772ZcfjzcM00+VZmJ3X/80ro1aQXBKA=; b=bGibeFr9cGNWqDbNIOSUYW7Llj
        lLWaIRI3XlQvpHr6Yew4WYm03E4jkONJS/HaXEh5MVZ8sDBrSZAeKmCErC01gOH75yIh/XjuSCD8+
        +iTsBchNubnllYTNxqEBMRniXslZXUQ4IEeoflUwSYTXtREucbKsbnvEOsoNLLSJ1qM+6BqXEruZn
        Qje4B4sqZ3X1MhXWfPn3ItghsMC3w6prTfPrhLnchZybpxEmcDG/uG5xLjYKp8pQiY2uJE3hCrSQk
        ah7il0wLDJGaj4Eb0RYvksFaanSbZEhhRXpQlOULZNsN7aA+1Hl1rWHPUoAs54ROTL82b0OfMyikE
        GoI5MR6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4V1f-00B6xX-03;
        Sun, 11 Dec 2022 22:42:27 +0000
Date:   Sun, 11 Dec 2022 22:42:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ufs: Change the signature of ufs_get_page()
Message-ID: <Y5Zc0qZ3+zsI74OZ@ZenIV>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
 <20221211213111.30085-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211213111.30085-3-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 11, 2022 at 10:31:10PM +0100, Fabio M. De Francesco wrote:
>  out_put:
>  	ufs_put_page(page);
> -out:
> -	return err;
>  out_unlock:
>  	unlock_page(page);
>  	goto out_put;

Something strange has happened, all right - look at the situation
after that patch.  You've got

out_put:
	ufs_put_page(page);
out_unlock:
	unlock_page(page);
	goto out_put;

Which is obviously bogus.
