Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4956F1805
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345900AbjD1MbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbjD1MbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:31:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2CB5BB3;
        Fri, 28 Apr 2023 05:31:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B602421C78;
        Fri, 28 Apr 2023 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682685076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28GHY7/8HVaK5Zz3Ca4qAWpDJ3QIyffZhRZRL8Rzw+U=;
        b=rWqwCeniojKYUprb5PV4Hm5IDd/2TDG9+3CODI90cf2pL5nG3oBqQenZ66XzeMyRPtowtt
        snraL0GfW2lBClkAY0AfAjCL6fb6llJyVVFYloLt4y+39U8GUC4xLV8xs8jFrASkiDy428
        kpLUyrUIthXSZU+89ZSZZslTP3emF8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682685076;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28GHY7/8HVaK5Zz3Ca4qAWpDJ3QIyffZhRZRL8Rzw+U=;
        b=X2m7pvYwOn5FZKb7Gf3n8UqUIZT9oSbUaOcwn+djaOOB5ILldoFNq+FhUKTVsIDArr5hgE
        /5GHinrWQm1krJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA3C91390E;
        Fri, 28 Apr 2023 12:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LJSJKZS8S2TLewAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 12:31:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0E17BA0729; Fri, 28 Apr 2023 14:31:16 +0200 (CEST)
Date:   Fri, 28 Apr 2023 14:31:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with
 fanotify
Message-ID: <20230428123116.morxkpbmfb4y2utw@quack3>
References: <20230425130105.2606684-1-amir73il@gmail.com>
 <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
 <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com>
 <df31058f662fe9ec9ad1cc59838f288b8aff10f0.camel@kernel.org>
 <CAOQ4uxhWzV7YJ_kPGg_4wHhWAd79_Xgo2uoDY+1K9sEtJcH_cA@mail.gmail.com>
 <20230428114002.3vqve7g76xonjs5f@quack3>
 <2d0f5a6cd8e9e92f871c95ce586234425e47b719.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d0f5a6cd8e9e92f871c95ce586234425e47b719.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 28-04-23 08:15:50, Jeff Layton wrote:
> On Fri, 2023-04-28 at 13:40 +0200, Jan Kara wrote:
> > On Thu 27-04-23 22:11:46, Amir Goldstein wrote:
> > > On Thu, Apr 27, 2023 at 7:36 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > There is also a way to extend the existing API with:
> > > > > 
> > > > > Perhstruct file_handle {
> > > > >         unsigned int handle_bytes:8;
> > > > >         unsigned int handle_flags:24;
> > > > >         int handle_type;
> > > > >         unsigned char f_handle[];
> > > > > };
> > > > > 
> > > > > AFAICT, this is guaranteed to be backward compat
> > > > > with old kernels and old applications.
> > > > > 
> > > > 
> > > > That could work. It would probably look cleaner as a union though.
> > > > Something like this maybe?
> > > > 
> > > > union {
> > > >         unsigned int legacy_handle_bytes;
> > > >         struct {
> > > >                 u8      handle_bytes;
> > > >                 u8      __reserved;
> > > >                 u16     handle_flags;
> > > >         };
> > > > }
> > > 
> > > I have no problem with the union, but does this struct
> > > guarantee that the lowest byte of legacy_handle_bytes
> > > is in handle_bytes for all architectures?
> > > 
> > > That's the reason I went with
> > > 
> > > struct {
> > >          unsigned int handle_bytes:8;
> > >          unsigned int handle_flags:24;
> > > }
> > > 
> > > Is there a problem with this approach?
> > 
> > As I'm thinking about it there are problems with both approaches in the
> > uAPI. The thing is: A lot of bitfield details (even whether they are packed
> > to a single int or not) are implementation defined (depends on the
> > architecture as well as the compiler) so they are not really usable in the
> > APIs.
> > 
> > With the union, things are well-defined but they would not work for
> > big-endian architectures. We could make the structure layout depend on the
> > endianity but that's quite ugly...
> > 
> 
> Good point. Bitfields just have a bad code-smell anyway.
> 
> Another idea would be to allow someone to set handle_bytes to a
> specified value that's larger than the current max of 128 (maybe ~0 or
> something), and use that as an indicator that this is a v2 struct.
> 
> So the v2 struct would look something like:
> 
> struct file_handle_v2 {
> 	unsigned int	legacy_handle_bytes;	// always set to ~0 or whatever
> 	unsigned int	flags;
> 	int		handle_type;
> 	unsigned int	handle_bytes;
> 	unsigned char	f_handle[];
> 	
> };

Well, there's also always the option of having:

struct file_handle {
	unsigned int handle_bytes_flags;
	int handle_type;
	unsigned char f_handle[];
};

And then helper functions like:

unsigned int file_handle_bytes(struct file_handle *handle)
{
	return handle->handle_bytes_flags & 0xffff;
}

unsigned int file_handle_flags(struct file_handle *handle)
{
	return handle->handle_bytes_flags >> 16;
}

(and similar for forming the handle_bytes_flags value).

That is well defined and compatible across architectures and compilers and
bearable (although a bit clumsy).

> ...but now I'm wondering...why do we return -EINVAL when
> f_handle.handle_bytes is > MAX_HANDLE_SZ? Is it really wrong for the
> caller to allocate more space for the resulting file_handle than will be
> needed? That seems wrong too. In fact, name_to_handle_at(2) says:
> 
> "The constant MAX_HANDLE_SZ, defined in <fcntl.h>, specifies the maximum
> expected size for a file handle.  It  is  not guaranteed upper limit as
> future filesystems may require more space."
> 
> So by returning -EINVAL when handle_bytes is too large, we're probably
> doing the wrong thing there.

Yeah, you're right. But at this point it can serve us well by making sure
there's no userspace passing absurdly high handle_bytes ;).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
