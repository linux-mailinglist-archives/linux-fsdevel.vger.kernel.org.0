Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500283FAC70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhH2POe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 11:14:34 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:49116 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhH2POd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:14:33 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKMSw-00H4Kj-Iq; Sun, 29 Aug 2021 15:11:22 +0000
Date:   Sun, 29 Aug 2021 15:11:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fat: add the msdos_format_name() filename cache
Message-ID: <YSujmt9vman41ecj@zeniv-ca.linux.org.uk>
References: <20210829142459.56081-1-calebdsb@protonmail.com>
 <20210829142459.56081-3-calebdsb@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829142459.56081-3-calebdsb@protonmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 02:25:29PM +0000, Caleb D.S. Brzezinski wrote:
> Implement the main msdos_format_name() filename cache. If used as a
> module, all memory allocated for the cache is freed when the module is
> de-registered.
> 
> Signed-off-by: Caleb D.S. Brzezinski <calebdsb@protonmail.com>
> ---
>  fs/fat/namei_msdos.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index 7561674b1..f9d4f63c3 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -124,6 +124,16 @@ static int msdos_format_name(const unsigned char *name, int len,
>  	unsigned char *walk;
>  	unsigned char c;
>  	int space;
> +	u64 hash;
> +	struct msdos_name_node *node;
> +
> +	/* check if the name is already in the cache */
> +
> +	hash = msdos_fname_hash(name);
> +	if (find_fname_in_cache(res, hash))
> +		return 0;

Huh?  How could that possibly work, seeing that
	* your hash function only looks at the first 8 characters
	* your find_fname_in_cache() assumes that hash collisions
are impossible, which is... unlikely, considering the nature of
that hash function
	* find_fname_in_cache(res, hash) copies at most 8 characters
into res in case of match.  Where does the extension come from?

Out of curiosity, how have you tested that thing?
