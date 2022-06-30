Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAC56264F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiF3W6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiF3W6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:58:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2D3B011;
        Thu, 30 Jun 2022 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S/+biBIIU9UdjIcwTOYXd9h3c56AURDSMTACq4UFluM=; b=j44wui+KQxn1Lo77Lh20kh2iO3
        XKEMwDRB4LpYKiYLtWM95ySbFIGAlT47iRtsZseqjZ0p/jHiYmTRwq5yupaTuY6nj8XAh2JSAMeqf
        NsYQkC63fru/VKsfQyViDzMfjfZJlg54Wjeb6vstPiwl7NCj8Wi0SqwvwcszyUISNF8ruDEmQW7Nd
        R6oea9ASJ30e29WXtaMehgRrcB90wDWm/m14ZBmh1d7vN+mbEAXr3+pX2dxrNs+UMe2IaItBmAcBZ
        39ThDuTAHgOfrUSbP4cVLkkiro6cPsZF2rxXzEgW+Crhax84ZIrghkbU7UJ9T/cgB0Ijpgbaj9/iq
        /yrRKw0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o736R-006if9-Gt;
        Thu, 30 Jun 2022 22:57:39 +0000
Date:   Thu, 30 Jun 2022 23:57:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v2 1/9] mm: Add msharefs filesystem
Message-ID: <Yr4qY32eHzJy5vvw@ZenIV>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <de5566e71e038d95342d00364c6760c7078cb091.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5566e71e038d95342d00364c6760c7078cb091.1656531090.git.khalid.aziz@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:52PM -0600, Khalid Aziz wrote:
> +static int
> +msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
> +{
> +	unsigned long hash = init_name_hash(dentry);
> +	const unsigned char *s = qstr->name;
> +	unsigned int len = qstr->len;
> +
> +	while (len--)
> +		hash = partial_name_hash(*s++, hash);
> +	qstr->hash = end_name_hash(hash);
> +	return 0;
> +}

What do you need that for and how is it different from letting it
use full_name_hash() (which is what it will do if you leave
dentry_operations->d_hash equal to NULL)?
