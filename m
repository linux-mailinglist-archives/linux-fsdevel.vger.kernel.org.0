Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91BDD0CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 12:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfJIKVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 06:21:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35992 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIKVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:21:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so1341373pfr.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NGIndCTE8KhRZkb8ZPgdgTbFHphaWq58jb9K01Ql4oU=;
        b=lq8wCc3W0v2Lwy6WeHgT0dVxquyu04Lfc/iCrFMlaJdXmIWYGk2sdXy5fnniCVsvl9
         jpMr7ZbIvJoJ/AwwPFXSwOMcpnAmCnlbXzxquDyF4P5g4PWPH4MPSdhTacq0Kqo8Yq/f
         1Y1KemAcYRsD0T+gkYSjWgBY9sPsGVd/Qf08DghHLVdg+rOcoc4yfUvXM9IVRr9jUkXJ
         e10aQkvBrwhuanpXMs+BFnM+/cc6i00GoCAPBVY+bEkoLzvodJkeqaMVo3CPAsr7KE0h
         p4Cd8edZmIAnRgjomjcsqxs0k+qW0/P33la563+IfrsHXuQfcirZbRnaSyOzGkm/1Pmt
         mMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGIndCTE8KhRZkb8ZPgdgTbFHphaWq58jb9K01Ql4oU=;
        b=URwl5+1iN+Ex0xj7JfokM6HJhSbolOHZKTTnMGFGuEvYfWj7UcuK+BPVI9GjMpqDQ3
         6MgjUTolxs/9Sa/9SEYWNXom2LVJsCvjpCf7sKPgjqQIQPjLkQRobcsfrguaZspiepcu
         tq3c7aFlM76Bykv7ZsLSfje+rraFO127DzNLZqprVRCHnDEeuDiyf8fRP4ty3F+axy2B
         kXg1VSMH7eDQ3AOaDmhE8vn5mYZ0GZMG53rkAkBm++wvPRAOS0Ft+LTzzunRhtUgNReH
         MecHdHevdAaXpLl3EMiN30F7JXrnY6yXcdutQUsPq9c9YepYVImGBI8qZKg1dNsMGtZI
         1zrw==
X-Gm-Message-State: APjAAAWsaJtofpqJ77ABWPVoOCEa7OlBBcxOs5KWZFOPDzbkTu50JGWI
        GN6pbr+W+Bk20NLZO08J+c9yGFb2f/1I
X-Google-Smtp-Source: APXvYqyWiwK/8Pz8taSMnqYN0BB0XGDTtn01LCq7sXhZ+yX4xt8c1eUES5eFMYgqzWbkSBbBwA0LKQ==
X-Received: by 2002:a65:5ac4:: with SMTP id d4mr3362341pgt.181.1570616479946;
        Wed, 09 Oct 2019 03:21:19 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id e4sm1717785pff.22.2019.10.09.03.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:21:19 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:21:13 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 6/8] ext4: move inode extension checks out from
 ext4_iomap_alloc()
Message-ID: <20191009102111.GB14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008112706.GI5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008112706.GI5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:27:06PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:34:36, Matthew Bobrowski wrote:
> > We lift the inode extension/orphan list handling logic out from
> > ext4_iomap_alloc() and place it within the caller
> > ext4_dax_write_iter().
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan! :)

--<M>--
