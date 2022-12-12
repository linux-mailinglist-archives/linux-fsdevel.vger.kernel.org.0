Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82664979B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 02:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiLLBHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 20:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLLBHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:07:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3D3B0;
        Sun, 11 Dec 2022 17:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TKg/eKOHSSglLF4faH0Eru24SwOHfMbXW57TNYDstk=; b=nmhY7ZqI75gEHuxNloTkcwhqZ8
        v5j/Gz1xiU++O39m/fF9XLZUN9CmWEbwf8FSP7YDLax4pAdnIueacCjsYPcZRo7GWmO5HfzilYNVJ
        Pk+VItICaAOhGSzcPFvLwH2qEMMjmFs1NE1VgUHeB3vboPrffDl8RRZwRncBb8A+Q7m9XZKm58+z5
        jamOH0+WVqarB8XcTS9+HkwHTCpkOhis4yozrT4AyUGkYWgka6RGZw6xNlCidkBHjSn9ukEzhQlNA
        KS8ExLXLWcbvxgez4gIAUOkcMq5fmKqnTLJhXMlpGkkfMfi2jIJWjtKbPAR4rzYg8ObC6/ao/VxOu
        +RNBq5Xg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4XI3-00B8PQ-14;
        Mon, 12 Dec 2022 01:07:31 +0000
Date:   Mon, 12 Dec 2022 01:07:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y5Z+05hRftbI0mxk@ZenIV>
References: <20221211213111.30085-4-fmdefrancesco@gmail.com>
 <202212120803.iPhHqCqR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212120803.iPhHqCqR-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 12, 2022 at 08:52:47AM +0800, kernel test robot wrote:

> >> fs/ufs/dir.c:210:22: warning: variable 'kaddr' is uninitialized when used here [-Wuninitialized]
>            ufs_put_page(*page, kaddr);
>                                ^~~~~
>    fs/ufs/dir.c:196:13: note: initialize the variable 'kaddr' to silence this warning
>            char *kaddr;
>                       ^
>                        = NULL
>    1 warning generated.

Warning is right, suggestion - worse than useless...
