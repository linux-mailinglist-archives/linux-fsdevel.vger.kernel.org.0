Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AC3ED70A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbhHPN0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241036AbhHPNYv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:24:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C01760F46;
        Mon, 16 Aug 2021 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629120259;
        bh=cKKMlSBWoufnd5Wsg7F5EwD3oZ+md/XLQSla6gfvJ+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPP/MhaP1q9ijHc4dooD0mpkxvWYLenMhsyyMx0F2eWTJw8LW3ykWy4l6K7pfHu9M
         QBkiFuVXoxnBKuIxSl4DjcVuGf2T9oSfQTZa3rSdiHAGvhXqinjpTQtwkMfB8iGj5L
         Vx3yyWLjDUbK+dh7ien7bt3vZoSkyptmive8EhBNdzqQLcAxwm/Vp2q9rY/dQLakje
         oMHb8IGGEf8/p0HbeeFF78vXj0bMcxM2p+Q2rYv085qFxV/lopvWC8z49k+pKJziux
         CwgBHUFqp5vzHiuB1EawC/BE0VAHVeBwr28f3Z3230bW7k+jF6HqHfL0VUUMDFO/Cs
         1hSUQNploooRA==
Received: by pali.im (Postfix)
        id 05797949; Mon, 16 Aug 2021 15:24:16 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:24:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/4] fs/ntfs3: Use new api for mounting
Message-ID: <20210816132416.zk326rbhwe7eaj3i@pali>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
 <20210816024703.107251-2-kari.argillander@gmail.com>
 <20210816123619.GB17355@lst.de>
 <20210816131417.4mix6s2nzuxhkh53@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816131417.4mix6s2nzuxhkh53@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 16 August 2021 16:14:17 Kari Argillander wrote:
> > > + * Load nls table or if @nls is utf8 then return NULL because
> > > + * nls=utf8 is totally broken.
> > > + */
> > > +static struct nls_table *ntfs_load_nls(char *nls)
> > > +{
> > > +	struct nls_table *ret;
> > > +
> > > +	if (!nls)
> > > +		return ERR_PTR(-EINVAL);
> > > +	if (strcmp(nls, "utf8"))
> > > +		return NULL;
> > > +	if (strcmp(nls, CONFIG_NLS_DEFAULT))
> > > +		return load_nls_default();
> > > +
> > > +	ret = load_nls(nls);
> > > +	if (!ret)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	return ret;
> > > +}
> > 
> > This looks like something quite generic and not file system specific.
> > But I haven't found time to look at the series from Pali how this all
> > fits together.
> 
> It is quite generic I agree. Pali's series not implemeted any new way
> doing this thing. In many cases Pali uses just load_nls and not
> load_nls_default. This function basically use that if possible. It seems
> that load_nls_default does not need error path so that's why it is nicer
> to use.

Yes, I'm using what is currently available. But providing some helper
function should be a nice cleanup.

> One though is to implement api function load_nls_or_utf8(). Then we do not
> need to test this utf8 stuff in all places.

Beware that there are more cases which can happen:

- iocharset is not specified
  --> then driver default behavior is used
      --> it is either some fixed encoding (e.g. iso8859-1, utf8) or
          CONFIG_NLS_DEFAULT (*); so it should behave like iocharset is
          set to that fixed encoding or CONFIG_NLS_DEFAULT
- iocharset is set to utf8
  --> then native utf8* functions should be used instead of nls
- iocharset is set to CONFIG_NLS_DEFAULT
  --> then load_nls_default() should be used which is IIRC guaranteed to
      not fail
- iocharset is not set to utf8, neither to CONFIG_NLS_DEFAULT
  --> then load_nls(iocharset) should be used; this may fail

(*) - it is pity that not all fs drivers are using CONFIG_NLS_DEFAULT
      and some are using some their own fixed encoding... it just
      increase mess and "user surprise"
