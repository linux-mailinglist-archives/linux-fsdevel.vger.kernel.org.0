Return-Path: <linux-fsdevel+bounces-29729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5497CFA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 02:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB731F22E53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 00:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF5B660;
	Fri, 20 Sep 2024 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zzZUsRx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200779D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726791960; cv=none; b=u7lZ2xlkHs5f6yIBq/PbaMEu3G6EB1sTT3wVDT3I4TlNADmwu3XjUOZ0QrkafF/yiUahQjAFEBCQm7q8TulZS6MqJJ13MF/yiK38hymArsB9GWzuxQlKQg5AlWphoVuxAM+w0AT6dtGY6QBafIyCo/+7p3rjdZY0mDP0Nxe4d28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726791960; c=relaxed/simple;
	bh=z2dt4nzsJjknC2v3KkVTQJwIm+oqEF2Bl8t5YAKAkis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apjPnHgUEPgPAUlIMd8+IfXQP3BbMKthuPau6PqASeCRI01Ut8RQJZNT0dgJmGFFiflx3jPnzNAvMtt+RKhUEOz0swttolmKa8l6zSGyC8losiekTl1GYQ/Xyz++Tmyxl+WczRDElqVQxNSK6ODAov9VxXdSmUH5KSq6MaxGHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zzZUsRx5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e3c98b5aso1100604b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726791958; x=1727396758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0rQNifIodJ4c+JfI7/BChV1HaxjDpxyzVyQAeW2s7s=;
        b=zzZUsRx5bw/+eCH4mu0k8yc5ZnJwLvThLAg/ifkGArpw31FwKhsMAraRymguwhuuaR
         BRFkjq9NnnxZx2HK4gUR0j/oK/LaDBHD5h7Wv4HU9qOOaOa51YuziXIjt15EqwhyAs0I
         Lthg7NjVLpuzxBtmZQsDWr1LMxlzTRZsiczsx+o49ZpiPCvxbxIWmWXo0Zx5tk92+HH+
         mT9uHtEui900UH+gR1ZZhto/cfvuSpJnS4ET43PK0ho9a9Av98Gci8ng9XP2ryBuaqBK
         GfZD0RaB8PGZgWIw3xeV29jZC4KCytzcebZQR1/A+tQ/PGpFzNToeyAl5Jk79faNCBmx
         OyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726791958; x=1727396758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0rQNifIodJ4c+JfI7/BChV1HaxjDpxyzVyQAeW2s7s=;
        b=rDpqGG87ssYy7oitmbgHWihOFRUyIRBKSgZGm2X997bozpm/F+JnZ5YekoooX+O/AG
         uhTVuHwlTYX5HlR3yJPBntIjSGJHrWe6frbEHn5t5HXN1oYAT8F1HlJBITiRl2/wjd43
         CGZGPxFp1DW6q7+jhCRmJF8tAjOsmREQj0A8Ous74chPJfR2WX1Of5nm90g1sZKebc2A
         eAh//hF2iVDhRvI2pip0uH5CCOkSxlMZxzmHNiXWqWMkIu/IX58NPJXdA9fDLmIVlzWf
         DV4Thqc9zmD9SB90r+aB0S/J+o5YR5fe1qV0Y1s1dRlwkJlmrAzYZW5z3+ekOKFr5fIr
         HEvA==
X-Forwarded-Encrypted: i=1; AJvYcCXwcl8UxsOC6i650HnSgbe5w3BlhPvYxfKWz9jai1uuRx41TNX+Ta3xeKscoeJ/q62n2lsyUBQmpI/0QHL5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0SqW5GfhOuJkinftYDeyRHdIIXWz0VVNy0tknm8NkAgZKDGl
	G4S8IBd+acaOcQCGNhcMx6WMVZEPPQvV5ubOJU2hX+jjO6HuBKE6arys/GZx7SU=
X-Google-Smtp-Source: AGHT+IG+KYpzAqAx/8j01hP1kK9twzYmYzsP1hZP+XPr4BEacEJmI2i/FgTilyCixlxXOdzY0dDrHQ==
X-Received: by 2002:a05:6a00:cc4:b0:714:157a:bfc7 with SMTP id d2e1a72fcca58-7199cd8c263mr1268483b3a.15.1726791957941;
        Thu, 19 Sep 2024 17:25:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7aed3sm8881794b3a.114.2024.09.19.17.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 17:25:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1srRT8-007SKz-0Z;
	Fri, 20 Sep 2024 10:25:54 +1000
Date: Fri, 20 Sep 2024 10:25:54 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: factor out a xfs_file_write_zero_eof helper
Message-ID: <ZuzBElgA34H7FAEl@dread.disaster.area>
References: <20240910043949.3481298-1-hch@lst.de>
 <20240910043949.3481298-7-hch@lst.de>
 <20240917211419.GC182177@frogsfrogsfrogs>
 <20240918050936.GA31238@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918050936.GA31238@lst.de>

On Wed, Sep 18, 2024 at 07:09:36AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 02:14:19PM -0700, Darrick J. Wong wrote:
> > I gotta say, I'm not a big fan of the "return 1 to loop again" behavior.
> > Can you add a comment at the top stating that this is a possible return
> > value and why it gets returned?
> 
> Sure.  If you have a better idea I'm all ears, too.

I would have thought a -EBUSY error would have been appropriate.
i.e. there was an extending write in progress (busy doing IO) so we
couldn't perform the zeroing operation and hence the write needs to
be restarted now the IO has been drained...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

