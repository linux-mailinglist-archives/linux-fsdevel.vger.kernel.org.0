Return-Path: <linux-fsdevel+bounces-53842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C19FAF80F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 21:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71C21895A23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D02FE317;
	Thu,  3 Jul 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIcuSayS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B12F94B5;
	Thu,  3 Jul 2025 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568999; cv=none; b=tkGxcR9Dgn23hIxHohepVlk74hKGciF4n2s20do5DhmE00i2aDjKIcTSt90YUpseEY3CxZRY/VnYBN4w5EmPBIEQtvbBUKSxJckC+/fLuKHPPVYt9eyhGna+HnM8GyFwZqFBHm/3i3nfl0qUkDO+EsOE4Hn6ceQH6V+tV161uko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568999; c=relaxed/simple;
	bh=UQAZ8zLttUZ8DRuWxXbltVWRlFbP9bIAenJaMLe7WlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgx2fVobCgCVgEPIlDWC2L6U3wtdAh35HHBhb7FcKGtqcdFSYtZkISf1K1HxyUYJ6z8IihWclkXk7xVhjfWJeHRZfCeEd5xd5t1uR+PH7o3SGBKnQCxwpSzc7qxHZa+J9qeNxsgKH5+V0JACb/K479K4qDKgx6oqMBWhvzew0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIcuSayS; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40a6692b75cso223555b6e.1;
        Thu, 03 Jul 2025 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568997; x=1752173797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0B3UqBqQulOzfupGyjVu5okNK2LnOMOlDR/fz/GO0Y=;
        b=dIcuSaySro3aEjboinSBxWCrSnyUIHbde9AFxbI0z1yB5PpdV3bE9sCbyT6iaAZ5St
         BkCelWTbZ2V47eXAORmHvNAIa0cdVpzUXT5Fv0Hzp39ljnNDUml7s712Qs2KqFVvCQWG
         e8jKLgurs0jHrOogYHBMFz36Y/S43XPWUylyYQHMfxTPDh0EcKlym4JTJZcHrO3LOKgW
         UK6Op8+H6F6DtxmyHq9ptPowdjEvQWTS7OC/DBQy84G6QvbFloYVLYdXBS42m+1cANeJ
         dFcFU4Qw0Cg2lu5YNakWeL9rCsuewmC56d1nq8w/PMhqfKsIOp2/p+O791hjXA/Zpn0r
         XBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568997; x=1752173797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0B3UqBqQulOzfupGyjVu5okNK2LnOMOlDR/fz/GO0Y=;
        b=oqz0786f995mFk/uMbdu/XCtW2H4iypllFla1aVe7scAhwVK8+yYCzLme0HwHGEvtk
         2OJ/IY/sNjRR2nRQ1o9VMbfsqRai6FBfBeux9ujoEhECeYOOQcv4ldSeN8UjlCuIyosJ
         HZVYVxTuKdx8hyObylpPrUJBOILACMT83MU2zbsmjme+Y8AGVv+fBjrQsi5uNxKVpbNK
         Qqx7VKCHVYoAX5VfucR4HOxi7O/EFtHBNI2HjBLl7LuE6kXp+f5irQNJH2y6UPWqTFEF
         OBukXXs9reR7f5hxzmikzr0qFSpbeEkt0bmb/lL1b52z/0bqt0EuEDQnbx1gTbpKX9fN
         cI1g==
X-Forwarded-Encrypted: i=1; AJvYcCU7gG9YYacxNrzetlpUt8oLVgwci4rHh9F+339mwy1pra2EbOZ/S06r/EdK2+Mb7ffv19RUUDXF9kVbXDG0@vger.kernel.org, AJvYcCUZh/VTFeIpdpxrgkP4YExgAvtYI8ELc0Ipm9hoNGW3Tpm7WmLCN27wq2aYBTd1GcrRxxTEEXapmbhE@vger.kernel.org, AJvYcCUuHyZazzggcZAtAl+tfLUhsncyfRs593J7nEzGdF4EiARXdJjND0lUMnkulQel/AmwYXjOE6TaTcP+vJFQSg==@vger.kernel.org, AJvYcCXu44EkV9FUFwo+I7QH8KGjOoaW7FmuFHTAubxuWMkCfSajGoczUP+lG7gvJ9hZSKPZmCCd8E4e54M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpnQdjQgdgufXlmr4Wz1Tjt3zeE+sruFBU0ghif8jyAS5J8io
	E2rJoIreV1fvjMMQ76J/WTUgR4Xvpzm8pfw2+Le7F2gZIMy0wuaf1vl8
X-Gm-Gg: ASbGnctZoCR3G3X9waukB42t1Q/lrmlFdnBUeCjER1a6p7XrOPOGJFQKos5OqHbfQ9k
	4poZvKgxKZ861x57UdV7cJ780BFUnjr7U3jsQEdYSivVrjb4gn/7JVq3YfXMN0aVVLqnFc32ch0
	Aq8DJD19ptN/NuI9BBFdX6wZDRVRhwEt7tpzp6FG3yuT9xViMzAGz1oIsKbCUDlKh7rq8TKhJHm
	pqsLxA7pOApyot7iLaMnfnTuCp1PEuqGH2N/WLA83OnqHtd1H2saRZrMZcnWk/q80Ros1vYZkHj
	A/em0rH3yYoXTWhw9QP69Tgmp1spXYVW2NrlqN7M8D2O2tZh23/+naNfFvCyXwqC7Fl1adHw+Uj
	N2Ab4o1ksTg==
X-Google-Smtp-Source: AGHT+IGASt9BPy2PeX5NaYh3/reWzvowDb/acQvtLTw6FIrvDHn+1U14JqW0DXZlujFkHDKYOQyFWA==
X-Received: by 2002:a05:6808:1919:b0:40a:a3a6:9179 with SMTP id 5614622812f47-40b8932fcc8mr7044822b6e.39.1751568997047;
        Thu, 03 Jul 2025 11:56:37 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02ae4172sm29988b6e.45.2025.07.03.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 11:56:36 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 3 Jul 2025 13:56:34 -0500
From: John Groves <John@groves.net>
To: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 00/18] famfs: port into fuse
Message-ID: <os4kk3dq6pyntqgcm4kmzb2tvzpywooim2qi5esvsyvn5mjkmt@zpzxxbzuw3lq>
References: <20250703185032.46568-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185032.46568-1-john@groves.net>

DERP: I did it again; Miklos' email is wrong in this series. 
Forwarding to him...

John


