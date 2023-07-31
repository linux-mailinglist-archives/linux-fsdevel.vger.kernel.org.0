Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587976A309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGaVhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjGaVh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:37:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDF1BEC;
        Mon, 31 Jul 2023 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LddVCcT5Tl/w5tkU77QzXl+CGDu6387cGpG48tppgHc=; b=0Ynn7Y/7W6+gDCwSOAZ/hzNhAf
        ncsnWc6Ebm0glt4s2jy+6ENEVw8CCnDcddcPxAeqCO1Vm6rOWP40UtXpk7WqdG3Sbb1q/3CucAmPZ
        qDhNbMsdf3BrUSfNJ1r9+31fDwhdC1gU4CacjWVr4B82FZjG4LdFg30afj+w9oiGhUs73HGFs/v/L
        xvY5hvk58sAfA5z4McMTW8BtxkIZN9OihahGe+3Vyzuv0tK0LxQraesPWqUx6J4ahrTelf12g654L
        J2r7IbQOEmrqGnynl/sNARXbjYdGVcA+NX/WO2gi/nP8HJYhRloIot6akbGmFUUqoN7p6p9WZ0onF
        W4rm/+EQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQaZO-00HOoz-18;
        Mon, 31 Jul 2023 21:36:50 +0000
Date:   Mon, 31 Jul 2023 14:36:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <joel.granados@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Kees Cook <keescook@chromium.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bridge@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
        David Ahern <dsahern@kernel.org>,
        netfilter-devel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Simon Horman <horms@verge.net.au>,
        Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com,
        Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <ZMgpck0rjqHR74sl@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Joel Granados (14):
>   sysctl: Prefer ctl_table_header in proc_sysctl
>   sysctl: Use ctl_table_header in list_for_each_table_entry
>   sysctl: Add ctl_table_size to ctl_table_header
>   sysctl: Add size argument to init_header
>   sysctl: Add a size arg to __register_sysctl_table
>   sysctl: Add size to register_sysctl
>   sysctl: Add size arg to __register_sysctl_init

This is looking great thanks, I've taken the first 7 patches above
to sysctl-next to get more exposure / testing and since we're already
on rc4.

Since the below patches involve more networking I'll wait to get
more feedback from networking folks before merging them.

>   sysctl: Add size to register_net_sysctl function
>   ax.25: Update to register_net_sysctl_sz
>   netfilter: Update to register_net_sysctl_sz
>   networking: Update to register_net_sysctl_sz
>   vrf: Update to register_net_sysctl_sz
>   sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
>   sysctl: Use ctl_table_size as stopping criteria for list macro

  Luis
