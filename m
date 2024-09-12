Return-Path: <linux-fsdevel+bounces-29265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A49775CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C3E285FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE81C32FA;
	Thu, 12 Sep 2024 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BQqPl3vC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8E192B73;
	Thu, 12 Sep 2024 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185482; cv=none; b=GA2kAh3Qg+TVXTXhRw3VdWRdmeFso2XFDnBjPKK/VeneTWssryTjlkv2qfK77qP0y5yJmEoHLxbq81bzTlvKzq3z1r+L5gIv5wdgkvaWi1suzuNajvxdGKAv0lc8Ebjk3yDbMmF+tl9dy6NRO8UJJPP7FhlCZj1diJpIih3Keok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185482; c=relaxed/simple;
	bh=wzS7NWwfBAD5/gcp4BhtXmqxKlcXVYKgAbXgTM+fYVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hya7tj7pSqHS0UV0g8fqfQE09rrC7YdBLeSLG79sskBxbc0YUQbWyfMQ+gbaTIQ2syr2hiFQdgfm2+APA7CqQkl+0nKEZhNpMuYJrUwcIJn1oQsUCYfS3dFuGbx+3lUtCHFlhhgyFrl2aivqwB8W2LuYUJfyko6MnaeZ+gKY9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BQqPl3vC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+uTreIPhEeUbUdLeE/WmAwK4uMRYmdo43yIVGufOawY=; b=BQqPl3vCxsPbn5xJyC4ewYDMWY
	UUlqQJeLirOQeSSvN8xlc2BHt6UrJxH+JI+J0PCyfjbMJDphVsunfRYEaBLm9xo3O8a/yawoP6YP5
	0lPM0mxm8nQh59QZpL3abOfTJqYvQPVxaAFitNeQtugK2TrF5HpcZQZ9E6YNyH8po+tjpHHQe8h6U
	p1bKYIIJ40UmGfsusWIIybH2RHmI6GpK67LtvVOh3+YWbNcQn8u9aLnhVoTRwgOg2AIyZdHO9aeQ7
	LeewfnqdhmN/5+oALfKV+SG0fkF5qL6kRMtbxRKntCcqfLbophqIwVTVVfojIM+DS9U4GcycqCOdh
	GO5Ih51A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sothE-0000000BoCw-3fim;
	Thu, 12 Sep 2024 23:57:56 +0000
Date: Fri, 13 Sep 2024 00:57:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: viro@kernel.org, brauner@kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 0/8] BPF follow ups to struct fd refactorings
Message-ID: <20240912235756.GN1049718@ZenIV>
References: <20240813230300.915127-1-andrii@kernel.org>
 <CAEf4BzY4v6D9gusa+fkY1qg4m-yT8VVFg2Y-++BdrheQMp+j6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY4v6D9gusa+fkY1qg4m-yT8VVFg2Y-++BdrheQMp+j6Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 27, 2024 at 03:55:28PM -0700, Andrii Nakryiko wrote:
> > They were also merged into bpf-next/for-next so they can get early testing in
> > linux-next.

Umm...  I see that stuff in bpf-next/struct_fd, but not in your for-next.

> Can you guys please take a look and let us know if this looks sane and
> fine to you? I kept Al's patches mostly intact (see my notes in the
> cover letter above), and patch #3 does the refactoring I proposed
> earlier, keeping explicit fdput() temporarily, until Al's
> __bpf_map_get() refactoring which allows and nice and simple CLASS(fd)
> conversion.
> 
> I think we end up at exactly what the end goal of the original series
> is: using CLASS(fd, ...) throughout with all the benefits.

Looks sane.

